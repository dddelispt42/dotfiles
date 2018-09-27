# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    # alias ls='ls --color=always'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    # alias grep='grep --color=always'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -A'
alias l='ls -CF'

######################################
# better use of changing directories #
######################################
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
function dir() { ls -l "$@" | grep '^d'; }

###########
# Editors #
###########
alias more="less -R"
alias m="more"
alias xe="~/bin/xe"
alias vi="$EDITOR"
alias v="$EDITOR"
alias edit="$EDITOR"

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

##########
# xterms #
##########
# bg: #a0b0c0 #d0d0d0 #c0b0a0 #c0a080
#     #fef9e3d6c9ba #a97cd644abd0 #b6c7a339a339 #aa6db65fc936 #a70ab2f09b24 #e0c3c127a9b2

alias xterm="xterm -name `hostname` -ls -sb -sl 1500 -bg $XTERM_COLOR -font fixed"
alias clip="xterm -fn fixed -title Clipboard -e tcsh -c 'cat > /dev/null' &"

######
# ls #
######
alias l="ls -lF"
alias ll="l -a"
alias lt="l -tr"
alias llt="ls -lat"
alias lltr="ls -latr"

######
# ps #
######
alias psg="ps -efa | grep"
alias myps="ps -efa \!* | grep $USER | grep -vE 'tcsh|$WINTERM|grep rh031132'"
alias mypsg="ps -efa | grep $USER | grep"

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
alias vim="vimTabs"
alias vi="vimTabs"

alias chx="$EDITOR $HOME/.exrc"
alias chv="$EDITOR $HOME/.vimrc"
alias chcron="crontab -r; $EDITOR $HOME/mycrontab.`hostname`; crontab $HOME/mycrontab.`hostname`"

# TODO: with parameter
alias vimprofile="vim --startuptime /tmp/vim.log && vim /tmp/vim.log"

alias home="while [ true ] ; do sleep 600 | ssh home; wait; done"

alias v="$VISUAL"
# because typing is hard
alias bim="$EDITOR"
alias ivm="$EDITOR"

alias :w="echo this isn\'t vim 🌟"
alias :q='exit'

# git
alias g='git'
alias gs='git status -sb'
# copy the current branch name
alias gcb='git rev-parse --abbrev-ref HEAD | pbcopy'
# because i make this typo a lot
alias ggs='gs'
alias cal='ncal -w -M -A 6 -B 1'
alias weather='curl wttr.in/lisbon'

# pass fzf to vim
alias vf='$EDITOR $(fzf)'

# alias cp="rsync --archive --human-readable --progress --verbose --whole-file"
# alias scp="rsync --archive --checksum --compress --human-readable --itemize-changes --rsh=ssh --stats --verbose"
alias myip="curl http://myip.dnsomatic.com && echo ''"
alias pandoc="pandoc --latex-engine=lualatex -H $HOME/.config/pandoc/fonts.tex"
alias pretty-json="python2 -mjson.tool"
alias gstlast='git ls-files --other --modified --exclude-standard|while read filename; do  echo -n "$(stat -c%y -- $filename 2> /dev/null) "; echo $filename;  done|sort'