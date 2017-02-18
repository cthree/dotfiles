#!/usr/bin/env bash
#
# Install some stuff
#

source ~/dotfiles.sh

command_exists () {                                                                                               
  type "$1" &> /dev/null                                                                                          
} 

if command_exists brew ; then
  SYSTEM="MACOS"
else
  SYSTEM="UBUNTU"
fi

if [ $SYSTEM eq "UBUNTU" ]; then
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
else
  # Install neovim
  brew install neovim/neovim/neovim
  
  # Install pythons
  brew install pip3
  brew install pip2
fi

# install the neovim python bits
pip3 install --user --upgrade neovim
pip2 install --user --upgrade neovim

# install the neovim gem
gem install neovim


