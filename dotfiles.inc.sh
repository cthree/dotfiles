#
# Common things
#

command_exists () {
  type "$1" &> /dev/null
}

if command_exists tput && [ $(tput colors) -gt 0 ] ; then
  HAS_COLOR=1
  NRM="\e[m"
  BLK="\e[0;30m"
  BLU="\e[0;34m"
  GRN="\e[0;32m"
  CYN="\e[0;36m"
  RED="\e[0;31m"
  PUR="\e[0;35m"
  MAG=$PUR
  YEL="\e[0;33m"
  WHT="\e[0;37m"
  BLD="$(tput bold)"
else
  # No colors
  HAS_COLOR=
fi

# Either Linux or Darwin or ...
export SYSTYPE=$(uname -a | awk '{print $1}')
