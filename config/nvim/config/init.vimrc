"
" Global/builtin settings and preferences.
" None of these are plugin dependent but might be defaults
" if redefined later.
"

" Disable the mouse. Console mouse is hokey
set mouse=""

" Set tabs to 2 spaces
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" Show line numbers
set number

" Probably not needed
set encoding=utf-8

" Remap leader key
let g:mapleader=','
let g:maplocalleader='\\'

" Seaching
set hlsearch
set incsearch
set ignorecase
set smartcase
" CR clears search highlight
map <CR> :noh<CR>

" Highlight the current cursor line and column (not)
set cursorline
" set cursorcolumn

set title " set window title

