# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# export FZF_DEFAULT_COMMAND='fd --type f'
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
# export FZF_DEFAULT_OPTS='-x --height 40% --reverse --border --inline-info'
# export FZF_DEFAULT_OPTS="-x --reverse --preview='head -100 {}' --preview-window=right:50%:wrap"
# export FZF_DEFAULT_OPTS="-x --multi --preview='head -100 {}' --preview-window=right:50%:wrap"
# To apply the command to CTRL-T as well
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

fja() {
    local issues url
    issues=$(cat ~/.config/JiraIssueCache*.issues | fzf -x -0 -m)
    if [ $? -ne 0 ]; then
        return
    fi
    url=$(echo $issues | sed -e 's@\s*@https:\/\/jira.intra.coriant.com\/browse\/@;s@\s.*@@')
    echo $url |
    while read -r line
    do
        xdg-open $line
    done
}

fj() {
    local issues url
    issues=$(cat ~/.config/JiraIssueCache*.issues | grep -vE "( Closed| Done| Descope| Resolve| Rejecte)" | fzf -x -0 -m)
    if [ $? -ne 0 ]; then
        return
    fi
    url=$(echo $issues | sed -e 's@\s*@https:\/\/jira.intra.coriant.com\/browse\/@;s@\s.*@@')
    echo $url |
    while read -r line
    do
        xdg-open $line
    done
}

# lists tmuxinator sessions and open tmux sessions for selection
function tx {
    local TMUXP_SESSIONS TMUX_SESSIONS SESSIONS SELECTED
    TMUXP_SESSIONS="$(ls ${TMUXP_CONFIGDIR}/*.yaml | sed -e 's/.*\///;s/\.yaml//')"
    TMUX_SESSIONS="$(tmux list-sessions 2>/dev/null | sed -e "s/\(:.*\)//")"
    SESSIONS="$((echo "$TMUXP_SESSIONS" && echo "$TMUX_SESSIONS" | grep -v "^$") | sort -u)"
    SELECTED="$(echo "$SESSIONS" | FZF_DEFAULT_OPTS="-x " fzf --tac --cycle -0 -1)"
    if [ $? -ne 0 ]; then
        return
    fi
    echo "$TMUX_SESSIONS" | grep "$SELECTED" > /dev/null
    if [ $? -eq 0 ]; then
        if [ -z "$TMUX" ]; then
            tmux a -d -t $SELECTED
        else
            tmux switch -t $SELECTED
        fi
    else
        tmuxp load $SELECTED
    fi
}

function open {
    cmd /c explorer "$(cygpath -w "$@")"
}

function fopen {
    # TODO: test, fix and make platform independent, Ctrl-C agnostic <12-03-19, Heiko Riemer> #
    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")
    # $(fzf -d "\n" | sed -e "s/ /\\\\ /g" | sed -e "s/^\(.*\)/open   \1/")
    $(open $(fzf -d "\n" | sed -e "s/^\(.*\)/\1/"))
    IFS=$SAVEIFS
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
function fe {
    # TODO: test, fix and make platform independent, Ctrl-C agnostic <12-03-19, Heiko Riemer> #
    # TODO: merge and use Ctrl-XXX <12-03-19, Heiko Riemer> #
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
# TODO not working
function fo {
  local out file key
  IFS=$'\n' out=($(fzf --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  # key=$(head -1 <<< "$out")
  # file=$(head -2 <<< "$out" | tail -1)
  key=$(echo "$out" | head -1)
  file=$(echo "$out" head -2 | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
function floc {
  local out files dir

  dir=""
  if [ $# -gt 0 ]; then
      if [ -d $1 ]; then
          pushd $1 > /dev/null
          dir="$(pwd)"
          popd > /dev/null
          shift
      fi
  fi
  IFS=$'\n' out="$(locate -Ai '*' $dir $@ | fzf -x -0 -m --expect=ctrl-o,ctrl-e,ctrl-p)"
  key=$(echo "$out" | head -1)
  files=$(echo "$out" | tail -n +2)

  if [[ -n $files ]]
  then
     echo  $files
     if [ "$key" = ctrl-o ]; then
         open $files
     elif [ "$key" = ctrl-p ]; then
         pushd "$(dirname $(echo $files | head -1))" > /dev/null
     elif [ "$key" = ctrl-e ]; then
         ${EDITOR:-vim} -- $files
     else
         ${EDITOR:-vim} -- $files
     fi
  fi
}

# fuzzy grep open via ag
function fgra {
  # ${EDITOR:-vim} +"$(ag -U --nobreak --noheading $@ | fzf -x -0 -1 -m | awk -F: '{print "e +" $2 " " $1 " | "}') bn"
  ${EDITOR:-vim} +"$(rg --hidden --no-ignore --no-ignore-vcs --vimgrep $@ | fzf -x -0 -1 -m | awk -F: '{print "e +" $2 " " $1 " | "}') bn"
}

# fuzzy grep open via ag
function fgr {
  ${EDITOR:-vim} +"$(rg --vimgrep $@ | fzf -x -0 -1 -m | awk -F: '{print "e +" $2 " " $1 " | "}') bn"
}

# fcd - cd to selected directory
function fcd {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf -x +m) &&
  # TODO use pushd
  cd "$dir"
}

# fcda - including hidden directories
function fcda {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf -x +m) && cd "$dir"
}

# fcdr - cd to selected parent directory
function fcdr {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf -x --tac)
  cd "$DIR"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
# TODO not working - fix it
function cf {
  local file

  #TODO update locate DB
  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf -x --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# fkill - kill process
function fkill {
  local pid
  pid=$(ps -ef | sed 1d | fzf -x -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
function fbr {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  # branch=$(echo "$branches" |
  #          fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(echo "$branches" | wc -l) )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
function fco {
  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
function fcoc {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf -x --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
function fshow {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --no-sort --ansi --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# fcoc_preview - checkout git commit with previews
function fcoc_preview {
  local commit
  commit=$( glNoGraph |
    fzf -x --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
function fshow_preview {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --ansi --no-multi \
            --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
function fstash {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    # mapfile -t out <<< "$out"
    echo "$out" | mapfile -t out
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# fgst - pick files from `git status -s`
function is_in_git_repo {
  git rev-parse HEAD > /dev/null 2>&1
}

function fgst {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  # local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  # eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -x -m "$@" | while read -r item; do
  git status -su | cut -c 4- | sed -e 's/.*-> //' | FZF_DEFAULT_OPTS=" --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -x -m "$@" | while read -r item; do
    printf '%q ' "$item" | cut -d " " -f 2
  done
  echo
  # TODO: add multiple actions like diff, checkout, add <27-09-18, Heiko Riemer> #
}

# ftags - search ctags
function ftags {
  local tagfile tagfiledir files key

  tagfile=""
  if [ -f ctags ]; then
      tagfile="ctags"
  elif [ -f ./.git/ctags ]; then
      tagfile="./.git/ctags"
  elif [ -f ./.svn/ctags ]; then
      tagfile="./.svn/ctags"
  elif [ -f ../ctags ]; then
      tagfile="../ctags"
  elif [ -f ../.git/ctags ]; then
      tagfile="../.git/ctags"
  elif [ -f ../.svn/ctags ]; then
      tagfile="../.svn/ctags"
  elif [ -f ../../ctags ]; then
      tagfile="../../ctags"
  elif [ -f ../../.git/ctags ]; then
      tagfile="../../.git/ctags"
  elif [ -f ../../.svn/ctags ]; then
      tagfile="../../.svn/ctags"
  elif [ -f ../../../ctags ]; then
      tagfile="../../../ctags"
  elif [ -f ../../../.git/ctags ]; then
      tagfile="../../../.git/ctags"
  elif [ -f ../../../.svn/ctags ]; then
      tagfile="../../../.svn/ctags"
  else
      return
  fi
  [ -e $tagfile ] || return
  tagfiledir=$(dirname $tagfile)
  # IFS=$'\n' line=$(
    # awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' $tagfile |
    # cut -c1-80 | fzf --nth=1,2
  # ) && ${EDITOR:-vim} $(echo "$line" | cut -f3) -c "set nocst" \
                                      # -c "silent tag $(echo "$line" | cut -f2)"
  IFS=$'\n' files=$(awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' $tagfile | awk '{print $1 "|" $2 "|" $3;}' | sed -e 's/\(.*\)|\(.*\)|\(.*\)/\1  \|\2                                       \|\3/' | sed -e 's/\(.*\)|\(.\{0,40\}\).*|\(.*\)/\1\2\3/' | fzf -x -m -0 -1 | awk '{print $3;}' | sed -e "s|\(.*\)|${tagfiledir}\/\1|")
  # TODO: call vim with additional params: -c "set nocst" -c "silent tag AlarmConverter" <02-08-18, Heiko Riemer> #

  # TODO: externalize in function and reuse <02-08-18, Heiko Riemer> #
  if [[ -n $files ]]
  then
     echo  $files
     if [ "$key" = ctrl-o ]; then
         open $files
     elif [ "$key" = ctrl-p ]; then
         pushd "$(dirname $(echo $files | head -1))" > /dev/null
     elif [ "$key" = ctrl-e ]; then
         ${EDITOR:-vim} -- $files
     else
         ${EDITOR:-vim} -- $files
     fi
  fi
}

# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf -x +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

# In tmux.conf
# bind-key 0 run "tmux split-window -l 12 'bash -ci ftpane'"

# c - browse chrome history
function chromeh {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  # fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
  fzf -x --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

function fbhist {
    links="$(sqlite3 $FIREFOX_PROFILE/places.sqlite 'select title,url from moz_places;' | fzf -x -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
    if [ "$links" != "" ] ; then
        firefox --new-tab $links
    fi
}

function fncbookm {
    local links
    $HOME/bin/get_nextcloud_bookmarks.sh
    links="$(cat $HOME/.cache/nextcloud_bookmarks.txt | fzf -x -e -m | sed -e 's/.*http/http/')"
    if [ "$links" != "" ] ; then
        firefox --new-tab $links
    fi
}

function fwiki {
    local files
    pushd ~/vimwiki > /dev/null # directories should all be defined once via ENV vars.
    IFS=$'\n' files=$(fzf -x -e -m)
    vim $files
    popd > /dev/null
}

function fbookm {
    # links="$(sqlite3 $FIREFOX_PROFILE/places.sqlite 'select title,url from moz_places;' | fzf -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
    IFS=$'\n' links=$(sqlite3 $FIREFOX_PROFILE/places.sqlite "select '<a href=''' || url || '''>' || moz_bookmarks.title || '</a><br/>' as ahref from moz_bookmarks left join moz_places on fk=moz_places.id where url<>'' and moz_bookmarks.title<>''" | sed -e "s/^<a href='\(.*\)'>\(.*\)<\/a><br\/>/\2  |||  \1/" | fzf -x -e -0 -1 --no-sort --multi | sed -e 's/.*|||  //')
    if [ "$links" != "" ] ; then
        firefox --new-tab $links
    fi
}

