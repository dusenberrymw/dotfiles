" ==== VIM, not vi ====
set nocompatible  " turn off compatibility with vi

" ==== Install plugins w/ vim-plug ====
if empty(glob('~/.vim/autoload/plug.vim'))  " install Plug if necessary
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
"Plug 'dusenberrymw/vim-colors-solarized'  " Solarized colorscheme
Plug 'dusenberrymw/vim-slime'             " Send text to any REPL in a vim terminal or tmux
"Plug 'JuliaEditorSupport/julia-vim'       " Julia support
Plug 'rust-lang/rust.vim'                 " Rust support.
function! BuildLanguageClient(info)
  " Info is a dictionary with 3 fields:
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !bash install.sh
    !/usr/local/bin/python3 -m pip install -U pip setuptools wheel
    !/usr/local/bin/python3 -m pip install -U python-language-server[yapf]
    "!julia -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer"); Pkg.add("StaticLint")'
  endif
endfunction
Plug 'autozimu/LanguageClient-neovim', {
    \'branch': 'next',
    \'do': function('BuildLanguageClient') }  " supports autocomplete, jump to declaration, & docs
Plug 'dusenberrymw/vim-mucomplete'            " autocomplete
"Plug 'rhysd/vim-grammarous'                   " Grammar check via `:GrammarousCheck`
"Plug 'ruanyl/vim-gh-line'                     " Open code in GitHub with `<leader>gh`
call plug#end()

" ==== General ====
set encoding=utf-8              " files should be utf-8
set laststatus=2                " always show the status line
set title                       " show file name in title bar
set ruler                       " show current cursor position at bottom right
set visualbell                  " no sounds
set backspace=indent,eol,start  " fix backspace issues
set autoread                    " automatically read the file if it has been changed outside of vim
set nolangremap                 " prevent mappings from breaking
set ttimeout                    " time out for key codes
set ttimeoutlen=100             " wait up to 100ms after Esc for special key
set spell                       " enable spell checking

" ==== Backup, swap, and undo files ====
set nobackup                    " turn off backup files
set directory=~/.vim/swap//     " global swap file dir w/ full path names (//)
set undofile                    " turn on undo files
set undodir=~/.vim/undo/        " global undo directory

" ==== Commands ====
set wildmode=longest,list,full  " shell-style tab completion
set wildmenu                    " show menu of possible commands as you type
set showcmd                     " show incomplete commands at bottom

" ==== Searching ====
set ignorecase                  " ignore case in file
set smartcase                   " unless search term has case
set incsearch                   " search while typing
set hlsearch                    " highlight search results

" ==== Indentation (default) ====
set tabstop=2                   " tabs should be 2 columns wide
set softtabstop=2               " tabs should be 2 columns wide
set shiftwidth=2                " indentation should be 2 columns wide
set smarttab                    " tabs should insert blanks according to `shiftwidth`
set expandtab                   " expand tabs to spaces
set autoindent                  " auto indent next line based on current line

" ==== Lines ====
set number relativenumber       " show number of current line & relative numbers of all other lines
set nowrap                      " don't soft-wrap to window width
set colorcolumn=80              " highlight column 100
set display+=lastline           " display as much of the last line as possible
set formatoptions+=j            " delete comment character when joining commented lines
set scrolloff=3                 " keep three lines between cursor and window edge

" ==== Windows/Panes ====
set splitbelow                  " open splits below current buffer
set splitright                  " open vertical splits to the right of the current buffer
set noequalalways               " don't automatically change split sizes

" ==== Theme ====
syntax on                       " turn on syntax highlighting
set background=dark
colorscheme solarized           " enable the dark solarized theme
if exists("$VIM_TERMINAL")      " prevent color issues with vim inside a vim terminal
  hi Normal ctermbg=None
endif

" ==== Filetypes ====
filetype plugin indent on       " automatic indentation based on language
runtime macros/matchit.vim      " Better syntax matching

autocmd BufRead,BufNewFile *.py
  \ setlocal tabstop=2 |
  \ setlocal shiftwidth=2 |
  \ setlocal softtabstop=2 |
  \ setlocal textwidth=80
  " these files only use 2 space indentation

autocmd BufRead,BufNewFile *.txt,*.tex,*.md,*.markdown,*.conf,COMMIT_EDITMSG
  \ setlocal wrap |
  \ setlocal linebreak |
  \ setlocal breakindent |
  \ setlocal showbreak=\ \  |
  \ setlocal colorcolumn= |
  \ :syn match markdownIgnore "\$.*_{.*\$" |
  \ noremap <expr> j (v:count == 0 ? 'gj' : 'j')|
  \ noremap <expr> k (v:count == 0 ? 'gk' : 'k')|
  \ noremap $ g$|
  \ noremap ^ g^
  " note: `noremap` instead of `nnoremap` to enable the same behavior in normal and visual modes

autocmd BufRead,BufNewFile *.scm.md
  \ setlocal tabstop=2 |
  \ setlocal shiftwidth=2 |
  \ setlocal filetype=scheme |
  \ setlocal filetype=markdown
  " Special setting for markdown with scheme code within setting ft to
  " scheme and then back to markdown.
  " Will trigger load of slimv, but retain markdown syntax highlighting.

autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
  " When editing a file, always jump to the last known cursor
  " position. Don't do it when the position is invalid, when inside an
  " event handler (happens when dropping a file on gvim), or when the
  " mark is in the first line (that is the default position when opening
  " a file).

" === Remove trailing whitespace on save. ====
fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" ==== Custom mappings ====
" Note: Make sure there are no spaces left after each command, or they
" will become part of the command.
" Map `jj` to `Escape, l` in Insert mode, where the `l` prevents the cursor
" from moving backwards.
inoremap jj <Esc>l

" Map `;` to `:` for convenience.
nnoremap ; :

" Force usage of hjkl instead of arrow keys.
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Sane splits.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Sane splits in terminal mode.
if has('nvim')  " neovim settings
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
elseif has("terminal")  " vim 8 settings
  " NOTE: Can use <C-\><C-n> or <C-W>N to switch to normal ("Terminal-Normal")
  " mode. However, in normal mode, the terminal buffer will not be updated.
  " Thus, the split navigation mappings switch away while keeping the terminal
  " buffer in Terminal-Job mode. In neovim, this issue does not exist.
  tnoremap <C-h> <C-w>h
  tnoremap <C-j> <C-w>j
  tnoremap <C-k> <C-w>k
  tnoremap <C-l> <C-w>l
endif

" Map spacebar to leader, which is `\` by default.
map <Space> <Leader>

" ==== Terminal settings ====
set shell=bash
if has('nvim')  " neovim settings
  autocmd TermOpen * setlocal bufhidden=hide  " prevent terminals from being deleted when switching
  autocmd TermOpen * setlocal statusline+=%f  " terminal name
  autocmd TermOpen * setlocal statusline+=%=job_id:\ %-10.3{b:terminal_job_id}  " job id for slime
elseif has("terminal")  " vim 8 settings
  " Prevent terminals from being deleted when switching.
  autocmd TerminalOpen * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
  hi Terminal ctermbg=None
endif

" ==== Vim-Slime settings ====
let g:slime_python_ipython = 1  " use special pasting for iPython
if has('nvim')  " neovim settings
  let g:slime_target = "neovim"  " enable Neovim terminal for slime
elseif has("terminal")  " vim 8 settings
  let g:slime_target = "vimterminal"  " enable Vim 8 terminal for slime
  let g:slime_vimterminal_config = {"term_finish": "close"}  " close term buffer when finished
else  " tmux settings
  " Leave tmux socket name set to `default`.
  " Target pane notes:
  "   ":"     means current window, current pane (a reasonable default)
  "   ":i"    means the ith window, current pane
  "   ":i.j"  means the ith window, jth pane
  "   "h:i.j" means the tmux session where h is the session identifier
  "           (either session name or number), the ith window and the jth pane
  "   "%i"    means i refers the pane's unique id
  " C-c C-c to send either the explicitly selected text, or the current
  " paragraph (i.e. results of `vip`).
  let g:slime_target = "tmux"  " enable TMUX by default
endif

" ==== Language Server settings ====
let g:LanguageClient_autoStart = 1
" NOTE: Need to `brew install julia rust rust-analyzer rustfmt ghc haskell-language-server`.
let g:LanguageClient_serverCommands = {
\  'python': ['/usr/local/bin/pyls'],
"\  'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
"\     using LanguageServer;
"\     using Pkg;
"\     import StaticLint;
"\     import SymbolServer;
"\     env_path = dirname(Pkg.Types.Context().env.project_file);
"\     debug = false;
"\     server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
"\     server.runlinter = true;
"\     run(server);
"\  '],
\ 'c': ['clangd'],
\ 'cpp': ['clangd'],
\ 'rust': ['rust-analyzer'],
"\ 'haskell': ['haskell-language-server-wrapper', '--lsp'],
\ }
let g:LanguageClient_useFloatingHover = 0
let g:LanguageClient_usePopupHover = 0

nnoremap <Leader>d :pc<CR> :call LanguageClient#textDocument_hover()<CR>h
nnoremap <leader>g :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>x :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>a :call LanguageClient#workspace_applyEdit()<CR>
nnoremap <leader>c :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>s :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <leader>m :call LanguageClient_contextMenu()<CR>

" ==== MUComplete settings ====
set completeopt-=preview  " prevent preview window from opening during auto-completion
set completeopt-=longest  " prevent autocompletion while typing, but still allow menu to pop up
set completeopt+=menuone,noselect
let g:mucomplete#always_use_completeopt = 1
"let g:mucomplete#enable_auto_at_startup = 1
"let g:mucomplete#completion_delay = 500  " milliseconds
set shortmess+=c  " Shut off completion messages

" ==== Julia settings ====
"let g:default_julia_version = '1.1'
"let g:latex_to_unicode_auto=1

" ==== LaTeX ====
" NOTE: will need to do the following to install `latexmk`:
" ```
" sudo chown -R dusenberrymw:staff /usr/local/texlive
" tlmgr update --self
" tlmgr install latexmk
" ```
let g:tex_flavor = "latex"  " assume LaTeX vs. plaintex
" start continuous compilation
fun! Latexmk()
  if has('nvim')  " neovim settings
    sp | resize 5 | term latexmk -pdf -pvc %
  else  " vim 8 settings
    term ++close ++rows=5 latexmk -pdf -pvc %
  endif
endfun
command! Latexmk :call Latexmk()
" cleanup
command! LatexmkClean term ++close ++rows=5 latexmk -C

" ==== Zotero ====
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'citep' : 'pandoc'
  let api_call = 'http://localhost:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction
noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

" Cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"  " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"  " Block in normal mode

" PDB
nnoremap <leader>b obreakpoint()<Esc>
nnoremap <leader>B Obreakpoint()<Esc>
