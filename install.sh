#!/usr/bin/env bash
#
# Install some stuff
#


DOTFILES="$HOME/dotfiles"
source "$DOTFILES/dotfiles.inc.sh"

printf "This script is untested. ${RED}Check it first${NRM} before running\n"
printf "to be sure you really want to do this!\n"
exit 1

if [ SYSTYPE = "Linux" ] ; then
  if [ -f "/etc/issue" -a $(cat "/etc/issue" | awk '{print $1}') = "Ubuntu" ]
     # Install neovim
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo apt-get update
    sudo apt-get install neovim -y
    
    # Install pythons
    sudo apt-get install python-dev python-pip python3-dev python3-pip -y
    sudo apt-get install python3-setuptools -y
    sudo easy_install3 pip

    # Replace vi/vim/editor with neovim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
  fi
elif [ SYSTYPE = "Darwin" ] ; then
  brew update

  # Install neovim
  brew install neovim/neovim/neovim

  sudo easy_install pip
  brew install python3
else
  echo "Don't know how to install on this system" && exit -1
fi

# install the neovim python bits
pip3 install --user --upgrade neovim
pip2 install --user --upgrade neovim

# install the neovim gem
if command_exists gem; then
  gem install neovim
else
  printf "Ruby not installed, neovim ruby support not available.\n"
  printf "Consider installing rbenv and one of more rubies.\n"
  printf "See: ${CYN}https://github.com/rbenv/rbenv${NRM}\n"
fi

# symlink the config
BACKUP_OPTS=--backup=existing -f
mv $BACKUP_OPTS ~/.bashrc ~/bashrc.orig 2> /dev/null
mv $BACKUP_OPTS ~/.bash_profile ~/bash_profile.orig 2> /dev/null
ln -s $DOTFILES/bash_profile ~/.bash_profile

mkdir -p ~/.config
mv $BACKUP_OPTS ~/.config/nvim ~/.config/nvim.orig 2> /dev/null
mv $BACKUP_OPTS ~/.vimrc ~/vimrc.orig 2> /dev/null
mv $BACKUP_OPTS ~/.vim ~/vim.orig 2> /dev/null
ln -s $DOTFILES/config/nvim ~/.config/nvim

# Install the vim plugins and exit
nvim -c PlugInstall -c q -c q

echo "All done!"

