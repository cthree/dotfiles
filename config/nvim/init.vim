"
" Neovim configuration
"
set mouse="" " Disable mouse

" Set tabs to 2 spaces
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

set number " Line numbers

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

set cursorline
" set curcorcolumn

set title " set window title

" Load Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

let g:airline_powerline_fonts = 1
set noshowmode " Redundant

let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" Run Neomake automatically
augroup neomake
  au! BufWritePost * Neomake
augroup END

let g:deoplete#enable_at_startup = 1

" use tab for completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Theme and appearance
syntax enable
let g:solarized_termcolors=16
set background=light
colorscheme solarized

