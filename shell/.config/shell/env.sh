# shellcheck disable=SC2148
# PS1='[\u@\h \W]\$ '

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# TERM
# export TERM="xterm-256color"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# set XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DESKTOP_DIR="$HOME/docs/desktop"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DOWNLOAD_DIR="$HOME/dl"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_PICTURES_DIR="$HOME/media/pix"
export XDG_PUBLICSHARE_DIR="$HOME/media/public"
export XDG_TEMPLATES_DIR="$HOME/media/temp"
export XDG_VIDEOS_DIR="$HOME/media/videos"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
export HISTFILE="${XDG_CACHE_HOME}"/history

# firefox profile
FIREFOX_PROFILE="$(test -d .mozilla/firefox && (find .mozilla/firefox/ -iname '*.default' | tail -1))"
export FIREFOX_PROFILE

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PATH=$HOME/bin:$HOME/opt:$HOME/.local/bin:$HOME/.config/dwm:$PATH
export PATH

export NNTPSERVER=news.aioe.org
export EDITOR="vim"
command -v nvim >/dev/null && export EDITOR="nvim"
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR
export BROWSER=elinks
if [ -n "${DISPLAY+1}" ]; then
	# export BROWSER=brave
	export BROWSER=qutebrowser
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
export AUTOSSH_POLL=20
export AUTOSSH_GATETIME=30
export AUTOSSH_PORT="$((20000 + RANDOM % 10000))"
export AUTOSSH_LOGLEVEL=0
export AUTOSSH_LOGFILE="$XDG_CACHE_HOME/autossh.log"

# ZSH env
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZPLUG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/zplug"

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
export TMUX_TMPDIR="${XDG_CACHE_HOME:-$HOME/.cache}/"

# enable CLICOLORS
export CLICOLORS=1

# special GCC colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# default terminal emulator
export TERMINAL=xterm
command -v st >/dev/null && export TERMINAL="st"
command -v foot >/dev/null && test -n "$WAYLAND_DISPLAY" && export TERMINAL="foot"

# my BIB file
export BIB=$HOME/Documents/uni.bib

# MAVEN
export MAVEN_HOME=/opt/maven
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

export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"

export _ZO_ECHO=1

# move dofiles to XDG dirs
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export KDEHOME="${XDG_CONFIG_HOME:-$HOME/.config}/kde"
export ICEAUTHORITY="{$XDG_CACHE_HOME:-$HOME/.cache}"/ICEauthority
export MINIKUBE_HOME="{$XDG_DATA_HOME:-$HOME/.local/share}"/minikube
export TERMINFO="{$XDG_DATA_HOME:-$HOME/.local/share}"/terminfo
export TERMINFO_DIRS="{$XDG_DATA_HOME:-$HOME/.local/share}"/terminfo:/usr/share/terminfo
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export GRADLE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gradle"
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export ANSIBLE_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export ANSIBLE_NOCOWS=1
export W3M_DIR="$XDG_DATA_HOME"/w3m
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export CRAWL_DIR="$XDG_DATA_HOME"/crawl/
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export BOGOFILTER_DIR="$XDG_CACHE_HOME"/bogofilter
export RANDFILE="$XDG_CACHE_HOME"/rnd
export GRADLE_HOME="$XDG_CACHE_HOME"/gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export IPYTHONDIR="$XDG_CACHE_HOME"/ipython
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
# TODO: works only with xinit not startx
# export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
# export VIMINIT='source "$XDG_CONFIG_HOME/nvim/init.vim"'
export SQLITE_HISTORY=$XDG_DATA_HOME/sqlite_history
# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
# export LESS=-R
# export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
# export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"           # Mozilla smooth scrolling/touchpads.
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm
export _Z_DATA="$XDG_DATA_HOME/z"
export _ZO_FZF_OPTS="-x --multi --height 50% --border --inline-info --preview='${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh {}' --preview-window=right:50%:wrap"

export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons

# JAVA
export PATH=/opt/java/bin:$PATH
export JAVA_HOME=/opt/java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Python - disable keyring
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# Poetry
export POETRY_VIRTUALENVS_IN_PROJECT=1

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
export KLAUT="$HOME/Sync/share/"
export TODOLIST="${KLAUT:-$HOME/Sync/share}/notes/work.org"

#WIKI
export WIKI_PATH="${HOME}/Sync/share/notes/"
#Dotfiles
export DOTFILES="${HOME}/dev/${USER}/dotfiles/"

# RSS FEEDS
# export SFEED_PIPER
# export SFEED_PIPER_INTERACTIVE
# export SFEED_PLUMBER
# export SFEED_PLUMBER_INTERACTIVE
# export SFEED_YANKER
# export SFEED_YANKER_INTERACTIVE
export SFEED_AUTOCMD="t3"
export SFEED_URL_FILE="$HOME/.cache/sfeed_urls"
export SFEED_CONFIG_FILE="${KLAUT:-$HOME/Sync/share}/_share/feeds/sfeedrc"
export SFEED_CACHE_DIR="$XDG_CACHE_HOME/sfeed/cache/"

# PROOTs on Android
if [[ "$ANDROID_ROOT" == "/system" ]]; then
	export PROOT_GENTOO="$HOME/proots/gentoo"
	export PATH=$HOME/.shortcuts:$PATH
fi

# fuzzy finder variables
# fzf --preview command for file and directory
export FZF_PREVIEW_CMD="${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh {}"
# export FZF_DEFAULT_COMMAND="rg --files -uu --follow || git ls-tree -r --name-only HEAD || rg --files || find ."
export FZF_DEFAULT_COMMAND='git ls-files 2>/dev/null || fd -t f --follow --color always || rg --file --follow --color always || find . -type f'
export FZF_DEFAULT_COMMAND_HIDDEN='fd -t f -HI --follow  --exclude "{.git,.venv}"'
export FZF_DEFAULT_COMMAND_DIR='fd -t d -HI --follow  --exclude "{.git,.venv}"'
# Gruvbox
# export FZF_COLORSCHEMA='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'
# Catppuccin Mocha
export FZF_COLORSCHEMA=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_DEFAULT_OPTS="--reverse -x -m --height 50% --border --ansi --inline-info \
	--preview='${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh {}' \
	--preview-window=right:50%:wrap $FZF_COLORSCHEMA \
	--prompt='▶' --pointer='→' --marker='✅'"
export SKIM_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND"
export SKIM_DEFAULT_OPTIONS="--reverse -x -m --height 50% --border --ansi --inline-info \
	--preview='${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh {}' \
	--preview-window=right:50%:wrap $FZF_COLORSCHEMA \
	--prompt='▶'"
export SKIM_DEFAULT_OPTIONS="$SKIM_DEFAULT_OPTIONS \
--color=fg:#cdd6f4,bg:#1e1e2e,matched:#313244,matched_bg:#f2cdcd,current:#cdd6f4,current_bg:#45475a,current_match:#1e1e2e,current_match_bg:#f5e0dc,spinner:#a6e3a1,info:#cba6f7,prompt:#89b4fa,cursor:#f38ba8,selected:#eba0ac,header:#94e2d5,border:#6c7086"

export FZF_CTRL_T_OPTS="--height 60% \
	--border sharp \
	--layout reverse \
	--prompt '∷ ' \
	--pointer ▶ \
	--marker ⇒"
export FZF_TMUX_OPTS="-p90%,90%"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export LAUNCHER=fzf-tmux
export CM_LAUNCHER=fzf-tmux
if [ -n "${DISPLAY+1}" ]; then
	export LAUNCHER="rofi -dmenu"
	export CM_LAUNCHER=rofi
fi

#FORGIT
# open git log in vim
export FORGIT_LOG_FZF_OPTS=' --bind="ctrl-e:execute(echo {} |grep -Eo [a-f0-9]+ |head -1 |xargs git show |vim -)" '
# pop from stash
# shellcheck disable=SC2016
export FORGIT_STASH_FZF_OPTS=' --bind="del:reload(git stash drop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)" --bind="ctrl-space:reload(git stash pop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)" '

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
