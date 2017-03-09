"
" vim-plig plugin configuration and plugin settings
"

call plug#begin('~/.config/nvim/plugged')

" Auto-complete/snippet injection/IDE features
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/echodoc.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

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
let g:deoplete#sources._ = [ 'ultisnips', 'buffer' ]

" Personal snippets location
let g:UltiSnipsSnippetsDir = "~/dotfiles/config/nvim/UltiSnips"

" use tab for completion, C-j for snippets
" let g:UltiSnipsExpandTrigger = "<C-j>"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Vim commentary needs some help with Elixir files
autocmd FileType elixir setlocal commentstring=#\ %s
" Ctrl-/ toggles line comments
nmap <C-/> :Commentary<CR>

" Open NERDTree when no file specified on launch
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Toggle NERDTree with Ctrl+N
map <C-n> :NERDTreeToggle<CR>

" Quit if NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

