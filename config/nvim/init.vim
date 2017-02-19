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

" Auto-complete/snippet injection
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/echodoc.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'sheerun/vim-polyglot'   " Syntax Highlighting/Language packs
Plug 'neomake/neomake'        " Lint/compile
Plug 'mattn/emmet-vim'        " Emmet support

" UI Enhancements
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Neomake config

" Lint elixer with credo
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" Run neomake on buffer save
augroup neomake
  autocmd! BufWritePost * Neomake
augroup END

" Auto completion config

let g:deoplete#enable_at_startup = 1

" use tab for completion
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Status line config

let g:airline_powerline_fonts = 1
set noshowmode " Suppress redundant mode indication

" Theme and appearance config
" * Use the Solarized Terminal.app styles, they have a custom
"   ANSI color map needed to make the colors look right.

syntax enable
let g:solarized_termcolors=16 " For Teminal.app
set background=light
colorscheme solarized

