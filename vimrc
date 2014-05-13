" Erik's awesome vimrc


set nocompatible " VIM not VI

execute pathogen#infect() 

syntax on
filetype plugin indent on
scriptencoding utf-8

set cursorline
hi cursorline guibg=#333333
hi CursorColumn guibg=#333333

" Backup and undo
set backup
" set undofile
set undolevels=1000
" set undoreload=10000
set history=1000

set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd

set laststatus=2 showmode number
set incsearch ignorecase smartcase hlsearch
set shortmess+=|
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=onemore
set spell

" Source editing
set nowrap
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4

" Plugin Stuff
"
"

" Directory setup

function! InitializeDirectories()
    let dir_list = { 
        \ 'backup': 'backupdir', 
        \ 'views': 'viewdir', 
        \ 'swap': 'directory'  }
"        \ 'undo': 'undodir' }

    for [dirname, settingname] in items(dir_list)
        let directory = $HOME . "/.vim/" . dirname
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            silent exec "!mkdir -p " . directory
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create " . directory . " for " . settingname
        else
            let directory = substitute(directory, " ", "\\\\ ", "")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction

call InitializeDirectories()

" Use vimrc.local if available

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif


