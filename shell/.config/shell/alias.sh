# shellcheck disable=SC2148
alias grep='grep --color=auto'

# some more ls aliases
command -v lsd >/dev/null && alias ls="lsd --group-dirs first"
command -v lsd >/dev/null && alias lt='ls --tree'
if command -v eza >/dev/null; then
	# general use
	alias ls='eza'                                                        # ls
	alias l='eza -lbF --git --icons'                                              # list, size, type, git
	alias ll='eza -lbGF --git --icons'                                            # long list
	alias llm='eza -lbG --git --sort=modified --icons'                            # long list, modified date sort
	alias la='eza -lbhHigmuSaa --time-style=long-iso --icons --git --color-scale' # all list
	alias lx='eza -lbhHigmuSa@ --time-style=long-iso --icons --git --color-scale' # all + extended list
	# specialty views
	alias lS='eza -1'               # one column, just names
	alias lt='eza --tree --level=2 --long --icons --git' # tree
	alias eza='eza --git --group-directories-first --classify'
else
	alias l='ls -l'
	alias ll='l'
	alias lla='ls -la'
	alias la='ls -A'
fi

######################################
# better use of changing directories #
######################################
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
# dir() { ls -l "$@" | grep '^d'; }

###########
# Editors #
###########
alias vi='$EDITOR'
alias v='$EDITOR'
alias edit='$EDITOR'

##########
# others #
##########
alias h="history"
alias hgr="h | grep"
alias g="grep"
alias a="alias"
alias s="source"
alias j="jobs -l"
# alias erase="stty istrip erase"
# alias makectags='ctags -f ./.git/tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .'
alias makectags='ctags -f tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .'
alias lsblk="lsblk -a -o 'NAME,MAJ:MIN,RM,RO,TYPE,SIZE,FSUSED,FSUSE%,LABEL,UUID,PTTYPE,FSTYPE,MOUNTPOINT'"

######
# ps #
######
alias psg="ps -efa | grep"
alias myps='ps -efa \!* | grep $USER | grep -vE "tcsh|$WINTERM|grep rh031132"'
alias mypsg='ps -efa | grep $USER | grep'

######
# df #
######
alias dfl="df -k -F ufs"
alias duks="du -k -s"

############
# cp/rm/mv #
############
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

########################################
# edit resource or configuration files #
########################################
# alias vim="vimTabs"
command -v nvim >/dev/null && alias vim="nvim"
command -v nvim >/dev/null && alias vimdiff="nvim -d"
command -v hwatch >/dev/null && alias watch='hwatch -c -d word'
alias vi="vim"
alias v='$VISUAL'
alias bim='$EDITOR'
alias ivm='$EDITOR'
alias :w="echo this is not vim 🌟"
alias :q='exit'
command -v weechat >/dev/null && alias weechat='weechat -d ${XDG_CONFIG_HOME}/weechat'
alias wget='wget --hsts-file=${XDG_DATA_HOME}/wget-hsts'

# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

#PAGER
if command -v bat >/dev/null; then
	alias more='bat'
	alias m='more'
fi
command -v tidy-viewer >/dev/null && alias tv="tidy-viewer"

# git
alias g='git'
alias gitui='gitui -t mocha.ron'
alias gs='git status -sb'
# copy the current branch name
alias gcb='git rev-parse --abbrev-ref HEAD | pbcopy'
alias cal='ncal -w -M -A 6 -B 1'
alias wttr='curl wttr.in/lisbon'
command -v eva >/dev/null && alias bc="eva"

# lf - list files (if mc is not installed)
command -v mc >/dev/null || alias mc='tmux split -h lf; lf'

# alias cp="rsync --archive --human-readable --progress --verbose --whole-file"
# alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias myip="curl http://myip.dnsomatic.com && echo ''"
# alias pandoc="pandoc --latex-engine=lualatex -H ${XDG_CONFIG_HOME:-$HOME/.config}/pandoc/fonts.tex"
alias pretty-json="python -mjson.tool"
alias music-dl='youtube-dl --audio-format=mp3 --extract-audio --metadata-from-title "%(artist)s - %(title)s"'
alias clip='xclip -selection clipboard'
alias top='htop'
#
# Docker aliases
alias chrome.sh='docker run --rm --name=chrome.sh -ti fathyb/carbonyl'
alias ff.sh='docker run --rm -it --name=browsh browsh/browsh'
alias dive='docker run --rm -it --name=dive --volume /var/run/docker.sock:/var/run/docker.sock:ro wagoodman/dive:latest'
alias ctop='docker run --rm -it --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest'
alias lazydocker='docker run --rm -it --name lazydocker -v /var/run/docker.sock:/var/run/docker.sock \
	-v lazydocker.config:/.config/jesseduffield/lazydocker \
lazyteam/lazydocker'
alias inotify-info='docker run --rm --name inotify-info --privileged -v /proc:/proc inotify-info'

alias path='echo -e ${PATH//:/\\n}'
alias ls_installed_debian_packages="aptitude search '~i!~M'"
# hors - check stackoverflow and other stuff in terminal
alias hors="hors -c -a"
alias tray="trayer --edge top --align center --expand false --width 5 --distance 20 &"
alias pacsize="pacman -Qi | grep -E '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
pacbloat() {
	pacman -Qe | awk '{print $1;}' | while read -r line; do
		if ! grep "$line" "$HOME"/dev/heiko/bootstrap/vars/*.pkgs >/dev/null; then
			echo "$line"
		fi
	done
}

# For spoken audio
alias yta="youtube-dl --format worstaudio --extract-audio --no-playlist"
# For music
alias ytmu="youtube-dl --format bestaudio --extract-audio --no-playlist"
# List formats & prompt for one
fyt() {
	youtube-dl --format "$(youtube-dl --list-formats "$1" | grep -E "^[0-9]+ " | fzf -1 -0 | awk '{print $1;}')" "$1"
}
# superresolution in python
# Usage:
#    enhance --zoom=1 --model=repair images/broken.jpg
#    enhance --zoom=2 "images/*.jpg"
# alias enhance='function ne() { docker run --rm -v "$(pwd)/`dirname ${@:$#}`":/ne/input -it alexjc/neural-enhance ${@:1:$#-1} "input/`basename ${@:$#}`"; }; ne'
alias thokr='thokr -w 200 -l english10k'
alias xbindkeys=xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config
alias svn=svn --config-dir "$XDG_CONFIG_HOME/subversion"
alias jui='docker run --rm -it -v $XDG_CONFIG_HOME/jira.d/:/config/ pmjohann/go-jira-ui'
alias X="startx"
alias W="dbus-run-session Hyprland"
