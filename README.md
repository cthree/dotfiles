# dotfiles README

***NIX environment and home directory dotfiles I find handy.**

Install by cloning into your home directory and then run the install.sh
contained in the dotfiles directory so install dependancies and create
links in your home directory:

    $ git clone git@github.com:cthree/dotfiles.git
    $ dotfiles/install.sh

## Text Editor

I use neovim as my preferred editor. Install.sh will install it. Plugin
management is handledby vim-plug. See the config/nvim/init.vim file
for details about what plugins are used and how they are configured.

## Shell

I use good ol' bash for my shell. It's available everywhere and does
everything I need and then some. 

The bash_profile file is fairly generic and I've tried to keep it
environment and host agnostic. It loads ~/.profile before anything
and loads ~/.bash_profile.local after everything. Make environment
specific tweeks in these files especially if they are platform or host
specific.

