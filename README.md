# dotfiles README

Home directory dotfiles I find handy.

Install by cloning into your home directory and then symlink the
files you want, for example:

    $ git clone git@github.com:cthree/dotfiles.git
    $ ln -sf ~/dotfiles/vimrc ~/.vimrc 

## vimrc

Note the the vimrc requires you install pathogen. You will get a 
warning when you run vim if you don't have it. Install it:

    mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -LSso ~/.vim/autoload/pathogen.vim \ 
        https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

Refer to pathogen's documentation for up-to-date instructions.

## bash_profile

The bash_profile file is fairly generic and I've tried to keep it
environment and host agnostic. It loads ~/.profile before anything
and loads ~/.bash_profile.local after everything. Make environment
specific tweeks in these files especially if they are platform or host
specific.

    ln -sf ~/dotfiles/bash_profile ~/.bash_profile

## profile-XXX

Platform specific settings are in these files. XXX denotes the platform.
symlink the appropriate one to ~/.profile or use as a template for your own.

    ln -sf ~/.dotfiles/profile-OSX ~/.profile
