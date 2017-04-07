" ==== VIM, not vi ====
set nocompatible                "turn off compatibility with vi

" ==== START VUNDLE ====
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just 
"                       :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to 
"                       auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" ==== Setup Vundle ====
filetype off                    "required while loading Vundle + plugins
set rtp+=~/.vim/bundle/Vundle.vim "set runtime path to include Vundle
call vundle#begin()             "initialize Vundle
Plugin 'VundleVim/Vundle.vim'      "let Vundle manage Vundle (required)

" ==== Install plugins w/ Vundle ====
"Plugin 'kovisoft/slimv'
"Plugin 'dusenberrymw/slimv'     "fixed bug for MIT-Scheme swank server
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
"Plugin 'amdt/vim-niji'          " rainbow parentheses for lisp
Plugin 'derekwyatt/vim-scala' " Scala support
Plugin 'altercation/vim-colors-solarized' " Solarized color theme

" ==== finish Vundle installs ====
call vundle#end()               "end Vundle plugin installation
" ==== END VUNDLE ====

" ==== General ====
set encoding=utf-8              "files should be utf-8
set title                       "show file name in title bar
set ruler                       "show current cursor position at bottom right
set visualbell                  "no sounds
set backspace=indent,eol,start  "fix backspace issues

" ==== Backup, swap, and undo files ====
set nobackup                    "turn off backup files
set directory=~/.vim/swap//     "global swap file dir w/ full path names (//)
set undofile                    "turn on undo files
set undodir=~/.vim/undo/        "global undo directory

" ==== Commands ====
set wildmode=longest,list,full  "shell-style tab completion
set wildmenu                    "show menu of possible commands as you type
set showcmd                     "show incomplete commands at bottom

" ==== Indentation (default) ====
set tabstop=2                   "tabs should be 2 columns wide
set shiftwidth=2                "indentation should be 2 columns wide
set expandtab                   "expand tabs to spaces

" ==== Lines ====
set nowrap                      "don't soft-wrap to window width
set colorcolumn=79              "highlight column 79

" ==== Scrolling ====
set scrolloff=3                 "keep three lines between cursor and window edge

" ==== Searching ====
set ignorecase                  "ignore case in file
set smartcase                   "unless search term has case
set incsearch                   "search while typing
set hlsearch                    "highlight search results

" ==== Solarized colorscheme
syntax enable
set background=dark
colorscheme solarized

" ==== Filetypes ====
filetype plugin indent on       "automatic indentation based on language
syntax on                       "turn on syntax highlighting

" ==== Filetype specific ====
autocmd BufRead,BufNewFile *.py
    \ set tabstop=2 |
    \ set shiftwidth=2
    "these files only use 2 space indentation

autocmd BufRead,BufNewFile *.txt,*.tex,*.md,*.markdown,*.conf
    \ setlocal wrap linebreak breakindent showbreak=\ \  |
    \ setlocal colorcolumn= |
    \ :syn match markdownIgnore "\$.*_{.*\$" |
    \ nnoremap j gj|
    \ nnoremap k gk|
    \ nnoremap $ g$|
    \ nnoremap ^ g^
    "wrap lines, maintaining indentation level of original line

autocmd BufRead,BufNewFile *.scm.md
    \ setlocal spell spelllang=en_us |
    \ set tabstop=2 |
    \ set shiftwidth=2 |
    \ set filetype=scheme |
    \ set filetype=markdown
    "special setting for markdown with scheme code within
    "setting ft to scheme and then back to markdown
    " will trigger load of slimv, but retain 
    " markdown syntax highlighting

autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
    " When editing a file, always jump to the last known cursor position. 
    " Don't do it when the position is invalid or when inside an event 
    "  handler (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the 
    "  default position when opening a file.

" ==== CUSTOM MAPPINGS ====
" NOTE: MAKE SURE THERE ARE NO SPACES LEFT AFTER EACH COMMAND, OR THEY WILL
"       BECOME PART OF THE COMMAND
" Remap 'Escape' in Insert mode ====
inoremap jj <Esc>l

" Remap ':' to ';' for convenience ====
nnoremap ; :

" Make scrolling faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Map Enter to writing and running the makefile ====
"noremap <CR> :w <bar> :make! <CR>

" Force usage of hjkl instead of arrow keys ====
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" ==== END CUSTOM MAPPINGS ====

" ==== Setup SLIMV for Lisp ====
"let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\"" -e "do script \"sbcl --load ~/.vim/slime/start-swank.lisp\"" -e "set miniaturized of front window to true" -e "end tell"'

