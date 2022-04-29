alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
command -v lsd > /dev/null && alias ls="lsd --group-dirs first"
command -v lsd > /dev/null && alias lt='ls --tree'
if command -v exa > /dev/null; then
    # general use
    alias ls='exa'                                                          # ls
    alias l='exa -lbF --git'                                                # list, size, type, git
    alias ll='exa -lbGF --git'                                             # long list
    alias llm='exa -lbG --git --sort=modified'                            # long list, modified date sort
    alias la='exa -lbhHigmuSaa --time-style=long-iso --git --color-scale'  # all list
    alias lx='exa -lbhHigmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
    # specialty views
    alias lS='exa -1'                                                              # one column, just names
    alias lt='exa --tree --level=2'                                         # tree
    alias exa='exa --git --group-directories-first --classify'
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
alias erase="stty istrip erase"
# alias makectags='ctags -f ./.git/tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .'
alias makectags='ctags -f tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .'
alias lsblk="lsblk -a -o 'NAME,MAJ:MIN,RM,RO,TYPE,SIZE,FSUSED,FSUSE%,LABEL,UUID,PTTYPE,FSTYPE,MOUNTPOINT'"

##########
# xterms #
##########
# bg: #a0b0c0 #d0d0d0 #c0b0a0 #c0a080
#     #fef9e3d6c9ba #a97cd644abd0 #b6c7a339a339 #aa6db65fc936 #a70ab2f09b24 #e0c3c127a9b2

# alias xterm='xterm -name $(hostname) -ls -sb -sl 1500 -bg $XTERM_COLOR -font fixed'
# alias clip="xterm -fn fixed -title Clipboard -e tcsh -c 'cat > /dev/null' &"


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
command -v nvim > /dev/null && alias vim="nvim"
command -v nvim > /dev/null && alias vimdiff="nvim -d"
command -v hwatch > /dev/null && alias watch='hwatch -c -d'
alias vi="vim"
alias v='$VISUAL'
alias bim='$EDITOR'
alias ivm='$EDITOR'
alias :w="echo this is not vim 🌟"
alias :q='exit'

# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

#PAGER
if command -v bat >/dev/null; then
    alias more='bat'
    alias m='more'
fi
command -v tidy-viewer > /dev/null && alias tv="tidy-viewer"

# git
alias g='git'
alias gs='git status -sb'
# copy the current branch name
alias gcb='git rev-parse --abbrev-ref HEAD | pbcopy'
alias cal='ncal -w -M -A 6 -B 1'
alias wttr='curl wttr.in/lisbon'
command -v eva > /dev/null && alias bc="eva"

# lf - list files (if mc is not installed)
command -v mc > /dev/null || alias mc='tmux split -h lf; lf'

# alias cp="rsync --archive --human-readable --progress --verbose --whole-file"
# alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias myip="curl http://myip.dnsomatic.com && echo ''"
# alias pandoc="pandoc --latex-engine=lualatex -H ${XDG_CONFIG_HOME:-$HOME/.config}/pandoc/fonts.tex"
alias pretty-json="python -mjson.tool"
alias music-dl='youtube-dl --audio-format=mp3 --extract-audio --metadata-from-title "%(artist)s - %(title)s"'
alias clip='xclip -selection clipboard'
alias top='htop'
alias ctop='docker run --rm -ti --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest'
alias path='echo -e ${PATH//:/\\n}'
alias ls_installed_debian_packages="aptitude search '~i!~M'"
# hors - check stackoverflow and other stuff in terminal
alias hors="hors -c -a"
alias tray="trayer --edge top --align center --expand false --width 5 --distance 20 &"
alias pacsize="pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
pacbloat() {
    pacman -Qe | awk '{print $1;}' | while read -r line; do
        if ! grep "$line" "$HOME"/dev/heiko/bootstrap/vars/*.pkgs > /dev/null; then
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
alias enhance='function ne() { docker run --rm -v "$(pwd)/`dirname ${@:$#}`":/ne/input -it alexjc/neural-enhance ${@:1:$#-1} "input/`basename ${@:$#}`"; }; ne'
