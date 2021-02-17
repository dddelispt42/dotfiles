# PS1='[\u@\h \W]\$ '

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# TERM
export TERM="xterm-256color"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# set XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/dl"
export XDG_TEMPLATES_DIR="$HOME/media/temp"
export XDG_PUBLICSHARE_DIR="$HOME/media/public"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_PICTURES_DIR="$HOME/media/pix"
export XDG_VIDEOS_DIR="$HOME/media/videos"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# firefox profile
FIREFOX_PROFILE="$(test -d .mozilla/firefox && (find .mozilla/firefox/ -iname '*.default' | tail -1))"
export FIREFOX_PROFILE

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PATH=~/bin:~/opt:~/.local/bin:~/.config/dwm:$PATH
export PATH

export NNTPSERVER=news.aioe.org
export EDITOR="vim"
command -v nvim > /dev/null && export EDITOR="nvim"
export VISUAL=$EDITOR
export BROWSER=elinks
if [ -n "${DISPLAY+1}" ]; then
    export BROWSER=brave
fi
export OPENER=xdg-open
if command -v mimeopen >/dev/null; then
    export OPENER=mimeopen
fi
export PAGER=less
if command -v bat >/dev/null; then
    export PAGER=bat
    export BAT_PAGER="less -RX"
fi

# AUTOSSH
export AUTOSSH_LOGFILE="$XDG_CACHE_HOME/autossh.log"

# ZSH env
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# GIT root
export GIT_ROOT=$HOME/dev

# Use nvim as manpager `:h Man`
# export MANPAGER='nvim +Man!'
# export MANWIDTH=999

export RED='\033[0;31m'
export YELLOW='\033[1;33m'
export GREEN='\033[0;32m'
export RESET_COLOR='\033[0m'

export DISABLE_AUTO_TITLE='true'

# TMUX
export TMUXP_CONFIGDIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmuxp"

# enable CLICOLORS
export CLICOLORS=1

# special GCC colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# default terminal emulator
export TERMINAL=st

# my BIB file
export BIB=$HOME/Documents/uni.bib

# MAVEN
export MAVEN_HOME=$HOME/opt/maven
export PATH=$PATH:$MAVEN_HOME/bin

# CARGO and RUST
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
PATH=$CARGO_HOME/bin:$RUSTUP_HOME:$PATH

# RFCs
export RFC_DIR=$XDG_CACHE_HOME/RFCs

# cht.sh
export CHTSH_HOME=$XDG_CACHE_HOME/cht.sh

# user logging
export USER_LOGS_DIR="$XDG_CACHE_HOME"/logs
mkdir -p "$USER_LOGS_DIR"

# pylint
export PYLINTHOME=${XDG_CONFIG_HOME:-$HOME/.config}/pylint

# move dofiles to XDG dirs
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export ANSIBLE_NOCOWS=1
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export CRAWL_DIR="$XDG_DATA_HOME"/crawl/
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export BOGOFILTER_DIR="$XDG_CACHE_HOME"/bogofilter
export RANDFILE="$XDG_CACHE_HOME"/rnd
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
# export VIMINIT='source "$XDG_CONFIG_HOME/nvim/init.vim"'
export SQLITE_HISTORY=$XDG_DATA_HOME/sqlite_history
# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
# export LESS=-R
# export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
# export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export _Z_DATA="$XDG_DATA_HOME/z"

# NNN related
export NNN_BMS='d:~/dev;D:~/Docs archive/'
export NNN_PLUG='o:fzy-open;d:ndiff,p:mocplay;m:nmount;t:thumb'
export NNN_USE_EDITOR=1
export NNN_CONTEXT_COLORS='1234'
export NNN_SSHFS_OPTS='sshfs -o reconnect,idmap=user'
export NNN_OPENER=$OPENER
# export NNN_IDLE_TIMEOUT=300
# export NNN_COPIER=copier
export NNN_TRASH=1

# DBUS - this is only needed for DWM with f***** systemd crappiness!!!
# export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

#KLAUT_ROOT
export KLAUT="$HOME/klaut/"

#VIMWIKI
export WIKI_PATH="$HOME/klaut/vimwiki/"

# fuzzy finder variables
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# export FZF_DEFAULT_COMMAND='rg --files -uu'
export FZF_DEFAULT_COMMAND='fd -HI --follow  --exclude "**/.git/**"'
export FZF_DEFAULT_OPTS="-x --multi --height 50% --border --inline-info --preview='${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh {}' --preview-window=right:50%:wrap"
export SKIM_DEFAULT_COMMAND="rg --files -uu --follow || git ls-tree -r --name-only HEAD || rg --files || find ."
export LAUNCHER=sk
export CM_LAUNCHER=fzf
if [ -n "${DISPLAY+1}" ]; then
    # export LAUNCHER="rofi -dmenu"
    export LAUNCHER=dmenu
    export CM_LAUNCHER=dmenu
fi

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"
