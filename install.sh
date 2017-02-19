#!/usr/bin/env bash
#
# Install some stuff
#

DOTFILES="$HOME/dotfiles"
source "$DOTFILES/dotfiles.inc.sh"

SYSTYPE=$(uname -a | awk '{print $1}')
if [ SYSTYPE = "Linux" ] ; then
  if [ -f "/etc/issue" -a $(cat "/etc/issue" | awk '{print $1}') = "Ubuntu" ]
     # Install neovim
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
    
    # Install pythons
    sudo apt-get install python-dev python-pip python3-dev python3-pip
    sudo apt-get install python3-setuptools
    sudo easy_install3 pip

    # Replace vi/vim/editor with neovim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor
  fi
elif [ SYSTYPE = "Darwin" ] ; then
  # Install neovim
  brew install neovim/neovim/neovim
  
  # Install pythons
  brew install pip3
  brew install pip2
else
  echo "Don't know how to install on this system" && exit -1
fi

# install the neovim python bits
pip3 install --user --upgrade neovim
pip2 install --user --upgrade neovim

# install the neovim gem
gem install neovim

# Install all the vim plugins and exit
nvim -c PlugInstall -c q -c q

# rbenv
# bash completions


