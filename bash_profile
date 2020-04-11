#
# cthree's most excellent interactive bash shell profile
#

DOTFILES="$HOME/dotfiles"
[[ -s "$DOTFILES/dotfiles.inc.sh" ]] && source "$DOTFILES/dotfiles.inc.sh"

# Load .profile first (if there is one)
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Set language to en_US with UTF-8 encoding to support filenames with non-ascii
# characters
export LC_CTYPE=en_US.UTF-8

# colorize ls output
export CLICOLOR=$HAS_COLOR
if [[ $HAS_COLOR ]]; then
  if command_exists dircolors; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi

  # BSD ls doesn't support --color= option so make sure ours does
  # before creating an alias using it
  ls --color=auto 2> /dev/null
  if [ $? = 0 ] ; then
    alias ls="ls --color=auto"
  fi
  alias grep="grep --color=auto"
  alias fgrep="grep --color=auto"
  alias egrep="grep --color=auto"
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# Ignore duplicate lines and lines starting with space in history file
HISTCONTOL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Check windows size on each command
shopt -s checkwinsize

# globular expansion (/**/)
shopt -s globstar 2> /dev/null
if [ $? = 0 ] ; then
  printf "${BLD}globstar enabled${NRM}\n"
fi

# minor spellcheck on directory names for cd
shopt -s cdspell

# local binaries path
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=/usr/local/man:$MANPATH

# use neovim if it is installed
if command_exists nvim ; then
  alias vim="nvim"
  alias vi="nvim"
fi

export VISUAL=vim

# Set default shell command prompt
PROMPT="\[${CYN}\]\u\[${NRM}\]@\[${BLU}\]\h\[${NRM}\]:\W"
PS1="${PROMPT} \$ "

# Load git command completion
[[ -s "$DOTFILES/git-completion.bash" ]] && source "$DOTFILES/git-completion.bash"

# Configure git aware shell prompt
GITPROMPT="$DOTFILES/git-prompt.sh"
if [[ -s "$GITPROMPT" ]] ; then
  source "$DOTFILES/git-prompt.sh"
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_STATESEPARATOR="|"
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWCOLORHINTS=$HAS_COLOR
  PROMPT_COMMAND='__git_ps1 "${PROMPT}" " \$ "'
fi

# some git command shortcuts
alias gst="git status"

# Load other account specific aliases from another file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# brew install bash-completion on mac
if ! shopt -oq posix; then
  if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# initialize rbenv if installed
if command_exists rbenv; then
  eval "$(rbenv init -)"
fi

# Enable iex REPL command line history
command_exists iex && export ERL_AFLAGS="-kernel shell_history enabled"

# Load the local-machine-specific bash_profile addendum last
[[ -s "$HOME/.bash_profile.local" ]] && source "$HOME/.bash_profile.local"
