# PS1='[\u@\h \W]\$ '

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# TERM
export TERM="xterm-256color"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export TERM=xterm-256color

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# path shortcuts
# CDPATH=".:~:~/projects:~/bin:~/dotfiles:~/docker"

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
PATH=/home/heiko/.gem/ruby/2.7.0/bin:$PATH
export PATH

# use vivid for more colors
if command -v vivid >/dev/null; then
    LS_COLORS="$(vivid generate molokai)"
    export LS_COLORS
fi

export NNTPSERVER=news.aioe.org
export EDITOR="vim"
export VISUAL="vim"
export BROWSER=elinks
export OPENER=xdg-open
if command -v mimeopen >/dev/null; then
    export OPENER=mimeopen
fi
export PAGER=less
if command -v bat >/dev/null; then
    export PAGER=bat
fi
export BAT_PAGER="less -RFX"
export XDG_CONFIG_HOME="$HOME/.config"
export AUTOSSH_LOGFILE="$HOME/autossh.log"

# Use nvim as manpager `:h Man`
export MANPAGER='nvim +Man!'
export MANWIDTH=999

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

# enable CLICOLORS
export CLICOLORS=1

# special GCC colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# default terminal emulator
export TERMINAL=st

# my BIB file
# TODO: make this work on all computers  <11-04-20, Heiko Riemer> #
export BIB=$HOME/Documents/uni.bib

# MAVEN
export MAVEN_HOME=~/opt/maven
export PATH=$PATH:$MAVEN_HOME/bin

# Fuzzy finder
# export FZF_DEFAULT_COMMAND='fd --type f'
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# export FZF_DEFAULT_OPTS='-x --height 40% --reverse --border --inline-info'
# export FZF_DEFAULT_OPTS="-x --reverse --preview='head -100 {}' --preview-window=right:50%:wrap"
# export FZF_DEFAULT_OPTS="-x --multi --preview='head -100 {}' --preview-window=right:50%:wrap"
export FZF_DEFAULT_OPTS="-x --multi --height 80% --border --inline-info --preview='~/.config/lf/preview.sh {}' --preview-window=right:50%:wrap"

# VIM related
# TODO:  <15-12-18, Heiko Riemer> #

# vimwiki
# TODO:  <15-12-18, Heiko Riemer> #

# NNN related
export NNN_BMS='d:~/git;D:~/Docs archive/'
export NNN_PLUG='o:fzy-open;d:ndiff,p:mocplay;m:nmount;t:thumb'
export NNN_USE_EDITOR=1
export NNN_CONTEXT_COLORS='1234'
export NNN_SSHFS_OPTS='sshfs -o reconnect,idmap=user'
export NNN_OPENER=$OPENER
# export NNN_IDLE_TIMEOUT=300
# export NNN_COPIER=copier
export NNN_TRASH=1

export LF_ICONS="\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
"
