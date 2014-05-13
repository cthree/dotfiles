# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" 

# Set language to en with UTF-8 encoding to support filenames with non-ascii
# characters
export LC_CTYPE=en_US.UTF-8

# colorize ls
export CLICOLOR=1

# local binaries path
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=/usr/local/man:$MANPATH

# Use vi(m) as visual editor
export VISUAL=vim

export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# MySQL from mysql.com
export PATH=/usr/local/mysql/bin:$PATH
export MANPATH=/usr/local/mysql/man:$MANPATH

# Command completion
. ~/.git_completion
. ~/.svn_completion

# Command prompt c/w [Git branch] if pwd is a repo
export PS1='\u@\h:\W$(__git_ps1 " [%s]") \$ '

# Git command aliases
alias gst="git status"
alias gci="git commit -v"
alias gco="git checkout"
alias gbr="git branch --color"
alias gadd="git add"

# ls shortcuts
alias l="ls -h"
alias ll="ls -lh"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
