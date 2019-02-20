stty -ixon -ixoff # turns off CTRL-S

# PS1='[\u@\h \W]\$ '

export TERM=xterm-256color

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# path shortcuts
CDPATH=".:~:~/projects:~/bin:~/dotfiles:~/docker"

# firefox profile
FIREFOX_PROFILE="$(test -d .mozilla/firefox && (find .mozilla/firefox/ -iname '*.default' | tail -1))"
export FIREFOX_PROFILE

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# PATH=~/bin:~/.cargo/bin:~/opt/neovim/bin:~/.fzf/bin:$PATH
PATH=~/bin:~/.cargo/bin:~/opt/neovim/bin:~/opt:~/.local/bin:/snap/bin:$PATH
export PATH

export NNTPSERVER=news.aioe.org
export EDITOR="vim"
export VISUAL="vim"
export BROWSER=elinks
export PAGER=less
export BAT_PAGER="less -RF"
if command -v bat >/dev/null; then
    export PAGER=bat
fi
export XDG_CONFIG_HOME="$HOME/.config"
export AUTOSSH_LOGFILE="$HOME/autossh.log"

# alias tmux="TERM=xterm-256color tmux"
# set LANG="en_US.UTF-8"

export RED='\033[0;31m'
export YELLOW='\033[1;33m'
export GREEN='\033[0;32m'
export RESET_COLOR='\033[0m'

# TODO: should I use vim server??? <12-11-18, Heiko Riemer> #
# alias vim="vim --servername a"
export DISABLE_AUTO_TITLE='true'

# ZSH related
export ZPLUG_HOME=~/.zplug

# TMUX
export TMUXP_CONFIGDIR=~/.config/tmuxp

# VIM related
# TODO:  <15-12-18, Heiko Riemer> #

# vimwiki
# TODO:  <15-12-18, Heiko Riemer> #
