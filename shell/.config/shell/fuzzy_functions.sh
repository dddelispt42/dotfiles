__handle_jira_issues() {
    local key issues urls
    key=$(echo "$1" | head -1)
    issues=$(echo "$1" | tail -n +2)
    urls=$(echo "$issues" | sed -e 's@\s*@https:\/\/jira.infinera.com\/browse\/@;s@\s.*@@')
    ids=$(echo "$issues" | sed 's/\s*\([A-Z]\+-[0-9]\+\).*/\1/')
    if [ "$key" = ctrl-o ]; then
        echo "$urls" | while read -r line; do
            xdg-open "$line"
        done
    elif [ "$key" = ctrl-u ]; then
        echo "$urls"
    elif [ "$key" = ctrl-p ]; then
        echo "$ids"
    elif [ "$key" = ctrl-y ]; then
        echo "$ids" | head -1 | xclip -selection c
    else
        echo "$ids" | head -1 | xclip -selection c
    fi
}

fja() {
    local output
    output=$(cat ~/.config/JiraIssueCache*.issues |
        FZF_DEFAULT_OPTS="-x --multi --height 100%" fzf --prompt="Select issue(s) [C-brOwser/Urls/Print/Yank1]> " -x -0 -m --expect=ctrl-o,ctrl-u,ctrl-p,ctrl-y)
    if [ $? -eq 0 ]; then
        __handle_jira_issues "$output"
    fi
}

fj() {
    local output
    output=$(cat ~/.config/JiraIssueCache*.issues |
        grep -vE "( Closed| Done| Descope| Resolve| Rejecte)" |
        FZF_DEFAULT_OPTS="-x --multi --height 100%" fzf --prompt="Select issue(s) [C-brOwser/Url/Print/Yank]> " -x -0 -m --expect=ctrl-o,ctrl-u,ctrl-p,ctrl-y)
    if [ $? -eq 0 ]; then
        __handle_jira_issues "$output"
    fi
}

__handle_files() {
    local key files
    key=$(echo "$1" | head -1)
    files=$(echo "$1" | tail -n +2)
    echo "Key: $key"
    echo "Files: $files"
    if [[ -n $files ]]; then
        if [ "$key" = ctrl-o ]; then
            echo "$files" | while read -r line; do
                xdg-open "$line"
            done
        elif [ "$key" = ctrl-p ]; then
            echo "$files" | while read -r line; do
                ~/.config/lf/preview.sh "$line"
            done
        elif [ "$key" = ctrl-e ]; then
            ${EDITOR:-vim} +"$(echo "$files" | awk '{print " e " $1 " | "}' && echo "bn")"
        else
            ${EDITOR:-vim} +"$(echo "$files" | awk '{print " e " $1 " | "}' && echo "bn")"
        fi
    fi
}

# ff [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
ff() {
    local output
    IFS=$'\n' output=$(FZF_DEFAULT_OPTS="-x --multi --height 100% --preview='~/.config/lf/preview.sh {}' --preview-window=right:50%:wrap" fzf --query="$1" --prompt="Select file(s) [Ctrl-Edit/Open/Preview]> " --expect=ctrl-o,ctrl-e,ctrl-p)
    if [ $? -eq 0 ]; then
        __handle_files "$output"
    fi
}
fconf() {
    pushd "$XDG_CONFIG_HOME" > /dev/null || return
    ff "$@"
    popd > /dev/null || return
}
function floc {
    local output dir
    dir=""
    if [ $# -gt 0 ]; then
        if [ -d "$1" ]; then
            pushd "$1" > /dev/null || return
            dir="$(pwd)"
            popd > /dev/null || return
            shift
        fi
    fi
    IFS=$'\n' output="$(locate -Ai '*' "$dir" "$@" | FZF_DEFAULT_OPTS="-x --multi --height 100% --preview='~/.config/lf/preview.sh {}' --preview-window=right:50%:wrap" fzf -x -0 -m --prompt="Select file(s) [Ctrl-Edit/Open/Preview]> " --expect=ctrl-o,ctrl-e,ctrl-p)"
    if [ $? -eq 0 ]; then
        __handle_files "$output"
    fi
}

function __handle_fuzzy_grep {
    local params cmd resultlist
    if [ "$1" -eq "1" ]; then
        params=-uu
        cmd=rga
    fi
    shift
    resultlist=$(${cmd:-rg} "$params" --vimgrep "$@" | fzf -x -0 -1 -m | sed 's/\(.*\):\([0-9]\+\):[0-9]\+:.*$/\1:\2/')
    if [ "$resultlist" != "" ]; then
        ${EDITOR:-vim} +"$(echo "$resultlist" | awk -F: '{print "e +" $2 " " $1 " | "}') bn"
    fi
}

# fuzzy grep open via ag
function fgra {
    __handle_fuzzy_grep 1 "$@"
}

# fuzzy grep open via ag
function fgr {
    __handle_fuzzy_grep 0 "$@"
}

# fkill - kill process
function fkill {
    local pid
    pid=$(ps -ef | sed 1d | FZF_DEFAULT_OPTS="" fzf -x -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        echo "$pid" | xargs kill -"${1:-9}"
    fi
}

# TODO: all above there fully tested - below not!!!

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
function fbr {
    local branches branch
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    # branch=$(echo "$branches" |
    #          fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    branch=$(echo "$branches" |
             fzf -d $(( 2 + $(echo "$branches" | wc -l) )) +m) &&
    git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
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
  git checkout "$(echo "$target" | awk '{print $2}')"
}

# fcoc - checkout git commit
function fcoc {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf -x --tac +s +m -e) &&
  git checkout "$(echo "$commit" | sed "s/ .*//")"
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
    local tagfile tagfiledir fileparam

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
    IFS=$'\n' fileparam=$(awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' $tagfile | awk '{print $1 "|" $2 "|" $3;}' | sed -e 's/\(.*\)|\(.*\)|\(.*\)/\1  \|\2                                       \|\3/' | sed -e 's/\(.*\)|\(.\{0,40\}\).*|\(.*\)/\1\2\3/' | fzf -x -m -0 -1 | awk -v tagpath="$tagfiledir/" '{print " e " tagpath $3 " | tag " $2 " | "}' && echo "bn")

    if [ $? -eq 0 ]; then
        ${EDITOR:-vim} +"$fileparam"
    fi
}

# lists tmuxinator sessions and open tmux sessions for selection
function tx {
    local TMUXP_SESSIONS TMUX_SESSIONS SESSIONS SELECTED
    TMUXP_SESSIONS="$(ls "${TMUXP_CONFIGDIR}"/*.yaml | sed -e 's/.*\///;s/\.yaml//')"
    TMUX_SESSIONS="$(tmux list-sessions 2>/dev/null | sed -e "s/\(:.*\)//")"
    SESSIONS="$((echo "$TMUXP_SESSIONS" && echo "$TMUX_SESSIONS" | grep -v "^$") | sort -u)"
    SELECTED="$(echo "$SESSIONS" | FZF_DEFAULT_OPTS="-x " fzf --tac --cycle -0 -1)"
    if [ $? -ne 0 ]; then
        return
    fi
    echo "$TMUX_SESSIONS" | grep "$SELECTED" > /dev/null
    if [ $? -eq 0 ]; then
        if [ -z "$TMUX" ]; then
            tmux a -d -t "$SELECTED"
        else
            tmux switch -t "$SELECTED"
        fi
    else
        tmuxp load "$SELECTED"
    fi
}

# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf -x +m --reverse) || return

  target_window=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ "$current_window" -eq "$target_window" ]]; then
    tmux select-pane -t "${target_window}.${target_pane}"
  else
    tmux select-pane -t "${target_window}.${target_pane}" &&
    tmux select-window -t "$target_window"
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
    open=xdg-open
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
    links="$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" 'select title,url from moz_places;' | fzf -x -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
    if [ "$links" != "" ] ; then
        firefox --new-tab "$links"
    fi
}

function fncbookm {
    local links
    $HOME/bin/get_nextcloud_bookmarks.sh
    links="$(cat "$HOME/.cache/nextcloud_bookmarks.txt" | fzf -x -e -m | sed -e 's/.*http/http/')"
    if [ "$links" != "" ] ; then
        firefox --new-tab "$links"
    fi
}

function fwiki {
    local files
    pushd ~/vimwiki > /dev/null # directories should all be defined once via ENV vars.
    IFS=$'\n' files=$(fzf -x -e -m)
    vim "$files"
    popd > /dev/null
}

function fbookm {
    # links="$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" 'select title,url from moz_places;' | fzf -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
    IFS=$'\n' links=$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" "select '<a href=''' || url || '''>' || moz_bookmarks.title || '</a><br/>' as ahref from moz_bookmarks left join moz_places on fk=moz_places.id where url<>'' and moz_bookmarks.title<>''" | sed -e "s/^<a href='\(.*\)'>\(.*\)<\/a><br\/>/\2  |||  \1/" | fzf -x -e -0 -1 --no-sort --multi | sed -e 's/.*|||  //')
    if [ "$links" != "" ] ; then
        firefox --new-tab "$links"
    fi
}

frga() {
    RG_PREFIX="rga --files-with-matches"
    local file
    file="$(
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
            fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                --phony -q "$1" \
                --bind "change:reload:$RG_PREFIX {q}" \
                --preview-window="70%:wrap"
    )" &&
    echo "opening $file" &&
    xdg-open "$file"
}

fssh() {
    $(grep -E ".*:[0-9];(auto)?ssh " "$XDG_CACHE_HOME/zhistory" | sed -e 's/.*:[0-9];\(auto\)\?ssh /\1ssh /;s/"/\"/g' | sort -u | fzf)
}

get_recipe()
{
    curl -sG "https://plainoldrecipe.com/recipe" -d "url=${1}" | pandoc -f html -t markdown
}
