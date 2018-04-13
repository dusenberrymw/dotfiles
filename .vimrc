" ==== VIM, not vi ====
set nocompatible  " turn off compatibility with vi

" ==== Install plugins w/ vim-plug ====
if empty(glob('~/.vim/autoload/plug.vim'))
  " install Plug if necessary
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
" Solarized colorscheme
Plug 'altercation/vim-colors-solarized'
" Send text to any REPL in a vim terminal or tmux
Plug 'jpalardy/vim-slime'
" Autocomplete, jump to declaration, & docs
Plug 'Valloric/YouCompleteMe', {'do': 'python3 install.py --clang-completer'}
" CtrlP fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" DML support
Plug 'nakul02/vim-dml'
" Scala support
Plug 'derekwyatt/vim-scala'
" Grammar check via `:GrammarousCheck`
Plug 'rhysd/vim-grammarous'
" Git plugins in order to be able to open code in GitHub, via the `:Gbrowse` feature
" kind of hate adding two plugins just for that feature, but they're small...
" `:Gbrowse` opens the link in the browser for the `origin` repository
" `:Gbrowse!` copies the link for the `origin` repository to the clipboard
" `:Gbrowse @repo` opens the link in the browser for the `repo` repository
" these work with visual selections as well
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
"Plug 'kovisoft/slimv'                   " SLIME mode for VIM (Lisp-only)
"Plug 'dusenberrymw/slimv'               "  - fixed bug for MIT-Scheme swank server
" Slimv notes:
" ,d -> run function
" ,e -> run s-expression
" ,b -> run entire file
" ,S -> splice outer pair of parens
" ,O -> split s-expressions
" ,J -> join s-expressions
" ,I -> raise s-expression subform
" ,< -> move paren to left
" ,> -> move paren to right
" ctrl-w w -> switch buffer window
call plug#end()

" ==== General ====
set encoding=utf-8              " files should be utf-8
set laststatus=2                " always show the status line
set title                       " show file name in title bar
set ruler                       " show current cursor position at bottom right
set visualbell                  " no sounds
set backspace=indent,eol,start  " fix backspace issues
set clipboard=unnamed           " use system clipboard for yank/paste
set number relativenumber       " show number of current line & relative numbers of all other lines
set spell                       " enable spell checking
set autoread                    " automatically read the file if it has been changed outside of vim
set nolangremap                 " prevent mappings from breaking
set ttimeout                    " time out for key codes
set ttimeoutlen=100             " wait up to 100ms after Esc for special key

" ==== Backup, swap, and undo files ====
set nobackup                    " turn off backup files
set directory=~/.vim/swap//     " global swap file dir w/ full path names (//)
set undofile                    " turn on undo files
set undodir=~/.vim/undo/        " global undo directory

" ==== Commands ====
set wildmode=longest,list,full  " shell-style tab completion
set wildmenu                    " show menu of possible commands as you type
set showcmd                     " show incomplete commands at bottom

" ==== Indentation (default) ====
set tabstop=2                   " tabs should be 2 columns wide
set softtabstop=2               " tabs should be 2 columns wide
set shiftwidth=2                " indentation should be 2 columns wide
set smarttab                    " tabs should insert blanks according to `shiftwidth`
set expandtab                   " expand tabs to spaces
set autoindent                  " auto indent next line based on current line

" ==== Lines ====
set nowrap                      " don't soft-wrap to window width
set colorcolumn=100             " highlight column 100
set display+=lastline           " display as much of the last line as possible
set formatoptions+=j            " delete comment character when joining commented lines

" ==== Scrolling ====
set scrolloff=3                 " keep three lines between cursor and window edge

" ==== Searching ====
set ignorecase                  " ignore case in file
set smartcase                   " unless search term has case
set incsearch                   " search while typing
set hlsearch                    " highlight search results
"set shell+=\ -O\ globstar       " use `shopt -s globstar` for `:grep` searches

" ==== Windows/Panes ====
set splitbelow                  " open splits below current buffer
set splitright                  " open vertical splits to the right of the current buffer

" ==== Filetypes ====
filetype plugin indent on       " automatic indentation based on language
syntax on                       " turn on syntax highlighting

" ==== Theme ====
syntax enable
set background=dark
colorscheme solarized           " enable the dark solarized theme

" ==== Filetype specific ====
autocmd BufRead,BufNewFile *.py
  \ setlocal tabstop=2 |
  \ setlocal shiftwidth=2 |
  \ setlocal softtabstop=2
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
  " position.  Don't do it when the position is invalid, when inside an
  " event handler (happens when dropping a file on gvim), or when the
  " mark is in the first line (that is the default position when opening
  " a file).

" ==== LaTeX ====
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
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Sane splits in terminal mode.
if has('nvim')  " neovim settings
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
elseif exists(":tnoremap")  " vim 8 settings
  " NOTE: `:terminal` could exist but not be available, so this is more robust
  " NOTE: Can use <C-\><C-n> or <C-W>N to switch to normal ("Terminal-Normal")
  " mode.  However, in normal mode, the terminal buffer will not be updated.
  " Thus, the split navigation mappings switch away while keeping the terminal
  " buffer in Terminal-Job mode.  In neovim, this issue does not exist.
  tnoremap <C-h> <C-w>h
  tnoremap <C-j> <C-w>j
  tnoremap <C-k> <C-w>k
  tnoremap <C-l> <C-w>l
endif

" Map spacebar to leader, which is `\` by default.
map <Space> <Leader>

" ==== Terminal settings ====
if has('nvim')  " neovim settings
  autocmd TermOpen * setlocal bufhidden=hide  " prevent terminals from being deleted when switching
  autocmd TermOpen * setlocal statusline+=%f  " terminal name
  autocmd TermOpen * setlocal statusline+=%=job_id:\ %-10.3{b:terminal_job_id}  " job id for slime
elseif exists(":tnoremap")  " vim 8 settings
  " NOTE: `:terminal` could exist but not be available, so this is more robust
  " prevent terminals from being deleted when switching
  autocmd BufWinEnter * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
endif

" ==== Vim-Slime settings ====
let g:slime_python_ipython = 1  " use special pasting for iPython
if has('nvim')  " neovim settings
  let g:slime_target = "neovim"  " enable Neovim terminal for slime
elseif exists(":tnoremap")  " vim 8 settings
  " NOTE: `:terminal` could exist but not be available, so this is more robust
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

" ==== YouCompleteMe settings ====
let g:ycm_python_binary_path = 'python3'  " use Python 3
" Show docs for current function
" NOTE: Use `:pc[lose]` to close the "preview" window
nnoremap <Leader>d :YcmCompleter GetDoc<CR>
nnoremap <Leader>g :YcmCompleter GoTo<CR>

" ==== Setup SLIMV for Lisp ====
"let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\"" -e "do script \"sbcl --load ~/.vim/slime/start-swank.lisp\"" -e "set miniaturized of front window to true" -e "end tell"'

