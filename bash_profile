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
export CLICOLOR=1

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
PROMPT="${CYN}\u${NRM}@${BLU}\h${NRM}:\W"
export PS1=$PROMPT

# Load git command completion 
[[ -s "$DOTFILES/git-completion.bash" ]] && source "$DOTFILES/git-completion.bash"

# Configure git aware shell prompt
GITPROMPT="$DOTFILES/git-prompt.sh"
if [[ -s "$GITPROMPT" ]] ; then
  source "$DOTFILES/git-prompt.sh"
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_STATESEPARATOR="|"
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export GIT_PS1_SHOWCOLORHINTS=true
  export PROMPT_COMMAND='__git_ps1 "${PROMPT}" " \$ "'
fi

# some git command shortcuts
alias gst="git status"
alias gls="git status --short"
alias gci="git commit -v -m"
alias gco="git checkout"
alias gbr="git branch --color"
alias gadd="git add"

# brew install bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# rbenv
eval "$(rbenv init -)"

# Load the local-machine-specific bash_profile addendum last
[[ -s "$HOME/.bash_profile.local" ]] && source "$HOME/.bash_profile.local"

