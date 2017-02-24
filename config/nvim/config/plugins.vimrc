"
" vim-plig plugin configuration and plugin settings
"

call plug#begin('~/.config/nvim/plugged')

" Auto-complete/snippet injection
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/echodoc.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'

Plug 'sheerun/vim-polyglot'   " Syntax Highlighting/Language packs
Plug 'neomake/neomake'        " Lint/compile
Plug 'mattn/emmet-vim'        " Emmet support

" UI Enhancements
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Lint elixer with credo
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" Run neomake on buffer save
autocmd! BufWritePost * Neomake

" Auto completion config

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources = {}
let g:deoplete#sources._ = [ 'buffer', 'ultisnips' ]

" Personal snippets location
let g:UltiSnipsSnippetsDir = "~/dotfiles/config/nvim/UltiSnips"

" use tab for completion, C-j for snippets
" let g:UltiSnipsExpandTrigger = "<C-j>"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

