" ==== VIM, not vi ====
set nocompatible  " turn off compatibility with vi

" ==== START VUNDLE ====
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" See :h vundle for more details or wiki for FAQ.

" ==== Setup Vundle ====
filetype off                       " required while loading Vundle + plugins
set rtp+=~/.vim/bundle/Vundle.vim  " set runtime path to include Vundle
call vundle#begin()                " initialize Vundle
Plugin 'VundleVim/Vundle.vim'      " let Vundle manage Vundle (required)

" ==== Install plugins w/ Vundle ====
Plugin 'altercation/vim-colors-solarized'  " Solarized colorscheme
Plugin 'jpalardy/vim-slime'                " Send text to any REPL in TMUX
Plugin 'ctrlpvim/ctrlp.vim'                " CtrlP fuzzy finder
Plugin 'nakul02/vim-dml'                   " DML support
Plugin 'derekwyatt/vim-scala'              " Scala support
"Plugin 'kovisoft/slimv'                   " SLIME mode for VIM (Lisp-only)
"Plugin 'dusenberrymw/slimv'               "  - fixed bug for MIT-Scheme swank server
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

" ==== Finish Vundle installs ====
call vundle#end()          " end Vundle plugin installation
filetype plugin indent on  " required after loading Vundle + plugins
" ==== END VUNDLE ====

" ==== General ====
set encoding=utf-8              " files should be utf-8
set title                       " show file name in title bar
set ruler                       " show current cursor position at bottom right
set visualbell                  " no sounds
set backspace=indent,eol,start  " fix backspace issues

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
set shiftwidth=2                " indentation should be 2 columns wide
set expandtab                   " expand tabs to spaces

" ==== Lines ====
set nowrap                      " don't soft-wrap to window width
set colorcolumn=100             " highlight column 100

" ==== Scrolling ====
set scrolloff=3                 " keep three lines between cursor and window edge

" ==== Searching ====
set ignorecase                  " ignore case in file
set smartcase                   " unless search term has case
set incsearch                   " search while typing
set hlsearch                    " highlight search results
set shell+=\ -O\ globstar       " use `shopt -s globstar` for `:grep` searches

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
  \ setlocal shiftwidth=2
  " These files only use 2 space indentation.

autocmd BufRead,BufNewFile *.txt,*.tex,*.md,*.markdown,*.conf,COMMIT_EDITMSG
  \ setlocal spell |
  \ setlocal wrap |
  \ setlocal linebreak |
  \ setlocal breakindent |
  \ setlocal showbreak=\ \  |
  \ setlocal colorcolumn= |
  \ :syn match markdownIgnore "\$.*_{.*\$" |
  \ nnoremap j gj|
  \ nnoremap k gk|
  \ nnoremap $ g$|
  \ nnoremap ^ g^

autocmd BufRead,BufNewFile *.scm.md
  \ setlocal spell |
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

" Remove trailing whitespace on save.
fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" ==== Custom mappings ====
" Note: Make sure there are no spaces left after each command, or they
"       will become part of the command.
" Map `jj` to `Escape, l` in Insert mode, where the `l` prevents the cursor
" from moving backwards.
inoremap jj <Esc>l

" Map `;` to `:` for convenience.
nnoremap ; :

" Make scrolling faster.
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Map Enter to writing and running the makefile.
"noremap <CR> :w <bar> :make! <CR>

" Force usage of hjkl instead of arrow keys.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Sane window splits.
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-h> <c-w>h
"nnoremap <c-l> <c-w>l

" ==== Setup SLIMV for Lisp ====
"let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\"" -e "do script \"sbcl --load ~/.vim/slime/start-swank.lisp\"" -e "set miniaturized of front window to true" -e "end tell"'

" ==== Vim-Slime settings ====
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
let g:slime_target = "tmux"     " enable TMUX by default
let g:slime_python_ipython = 1  " use special pasting for iPython

