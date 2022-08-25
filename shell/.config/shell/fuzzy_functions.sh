# shellcheck disable=2148

__handle_jira_issues() {
	local key issues urls
	key=$(echo "$1" | head -1)
	issues=$(echo "$1" | tail -n +2)
	urls=$(echo "$issues" | sed -e 's@\s*@https:\/\/jira.infinera.com\/browse\/@;s@\s.*@@')
	# shellcheck disable=SC2001
	ids=$(echo "$issues" | sed -e 's@\s*\([A-Z]\+-[0-9]\+\).*@\1@')
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
	output=$(cat "${XDG_CACHE_HOME:-$HOME/.cache}"/JiraIssueCache*.issues | FZF_DEFAULT_OPTS="-x --multi --height 100%" fzf --prompt="Select issue(s) [C-brOwser/Urls/Print/Yank1]> " -x -0 -m --expect=ctrl-o,ctrl-u,ctrl-p,ctrl-y)
	if [ -z ${output+x} ]; then
		return
	fi
	__handle_jira_issues "$output"
}

fj() {
	local output
	output=$(cat "${XDG_CACHE_HOME:-$HOME/.cache}"/JiraIssueCache*.issues | grep -vE "( Closed| Done| Descope| Resolve| Rejecte)" | FZF_DEFAULT_OPTS="-x --multi --height 100%" fzf --prompt="Select issue(s) [C-brOwser/Url/Print/Yank]> " -x -0 -m --expect=ctrl-o,ctrl-u,ctrl-p,ctrl-y)
	if [ -z ${output+x} ]; then
		return
	fi
	__handle_jira_issues "$output"
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
				print -s -- xdg-open "$line"
				xdg-open "$line"
			done
		elif [ "$key" = ctrl-p ]; then
			echo "$files" | while read -r line; do
				print -s -- "${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh" "$line"
				"${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh" "$line"
			done
		elif [ "$key" = ctrl-e ]; then
			# shellcheck disable=SC2046
			print -s -- ${EDITOR:-vim} $(echo "$files" | while read -r line; do echo "$line"; done)
			# shellcheck disable=SC2046
			${EDITOR:-vim} $(echo "$files" | while read -r line; do echo "$line"; done)
		else
			# shellcheck disable=SC2046
			print -s -- ${EDITOR:-vim} $(echo "$files" | while read -r line; do echo "$line"; done)
			# shellcheck disable=SC2046
			${EDITOR:-vim} $(echo "$files" | while read -r line; do echo "$line"; done)
		fi
	fi
}

# ff [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
ff() {
	local output
	IFS=$'\n' output=$(FZF_DEFAULT_OPTS="-x --multi --height 100% --preview='${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh {}' --preview-window=right:50%:wrap" fzf --query="$1" --prompt="Select file(s) [Ctrl-Edit/Open/Preview]> " --expect=ctrl-o,ctrl-e,ctrl-p)
	if [ -z ${output+x} ]; then
		return
	fi
	__handle_files "$output"
}
fconf() {
	pushd "$XDG_CONFIG_HOME" >/dev/null || return
	ff "$@"
	popd >/dev/null || return
}
function floc {
	local output dir
	dir=""
	if [ $# -gt 0 ]; then
		if [ -d "$1" ]; then
			pushd "$1" >/dev/null || return
			dir="$(pwd)"
			popd >/dev/null || return
			shift
		fi
	fi
	IFS=$'\n' output="$(locate -Ai '*' "$dir" "$@" | FZF_DEFAULT_OPTS="-x --multi --height 100% --preview='${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh {}' --preview-window=right:50%:wrap" fzf -x -0 -m --prompt="Select file(s) [Ctrl-Edit/Open/Preview]> " --expect=ctrl-o,ctrl-e,ctrl-p)"
	if [ -z ${output+x} ]; then
		return
	fi
	__handle_files "$output"
}

function __handle_fuzzy_grep {
	local cmd resultlist
	cmd=rg
	if [ "$1" -eq "0" ]; then
		# echo "${cmd:-rg} --vimgrep --line-number $2"
		resultlist=$(${cmd:-rg} --vimgrep --line-number "$2" 2>/dev/null | fzf -x -0 -1 -m)
	else
		command -v rga >/dev/null && cmd=rga
		# echo "${cmd:-rg} --vimgrep --line-number -uuu $2"
		resultlist=$(${cmd:-rg} --vimgrep --line-number -uuu "$2" 2>/dev/null | fzf -x -0 -1 -m)
	fi
	if [ "$resultlist" != "" ]; then
		# shellcheck disable=SC2046
		print -s -- ${EDITOR:-vim} $(echo "$resultlist" | while read -r line; do echo "$line" | awk -F : '{print $1 ":" $2;}'; done)
		# shellcheck disable=SC2046
		${EDITOR:-vim} $(echo "$resultlist" | while read -r line; do echo "$line" | awk -F : '{print $1 ":" $2;}'; done)
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

	if [ "x$pid" != "x" ]; then
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
			fzf -d $((2 + $(echo "$branches" | wc -l))) +m) &&
		print -s -- git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
	git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

# fgst - pick files from `git status -s`
function is_in_git_repo {
	git rev-parse HEAD >/dev/null 2>&1
}

# ftags - search ctags
function ftags {
	local tagfile tagfiledir fileparam

	tagfile=""
	if [ -f tags ]; then
		tagfile="tags"
	elif [ -f ../tags ]; then
		tagfile="../tags"
	elif [ -f ../../tags ]; then
		tagfile="../../tags"
	elif [ -f ../../../tags ]; then
		tagfile="../../../tags"
	elif [ -f ../../../../tags ]; then
		tagfile="../../../../tags"
	elif [ -f ../../../../../tags ]; then
		tagfile="../../../../../tags"
	elif [ -f ../../../../../../tags ]; then
		tagfile="../../../../../../tags"
	elif [ -f ../../../../../../../tags ]; then
		tagfile="../../../../../../../tags"
	else
		return
	fi
	[ -e $tagfile ] || return
	tagfiledir=$(dirname $tagfile)
	# IFS=$'\n' fileparam=$(awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' $tagfile | awk '{print $1 "|" $2 "|" $3;}' | sed -e 's/\(.*\)|\(.*\)|\(.*\)/\1  \|\2                                       \|\3/' | sed -e 's/\(.*\)|\(.\{0,40\}\).*|\(.*\)/\1\2\3/' | fzf -x -m -0 -1 | awk -v tagpath="$tagfiledir/" '{print " e " tagpath $3 " | tag " $2 " | "}' && echo "bn");
	IFS=$'\n' fileparam=$(awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' $tagfile | awk '{print $1 "|" $2 "|" $3;}' | sed -e 's/\(.*\)|\(.*\)|\(.*\)/\1  \|\2                                       \|\3/' | sed -e 's/\(.*\)|\(.\{0,40\}\).*|\(.*\)/\1\2\3/' | fzf -x -m -0 -1 | while read -r line; do echo "$tagfiledir/$(echo "$line" | awk '{print $3;}')"; done)
	if [ -z ${fileparam+x} ]; then
		return
	fi
	# shellcheck disable=2086
	print -s -- ${EDITOR:-vim} $fileparam
	# shellcheck disable=2086
	${EDITOR:-vim} $fileparam
}

# lists tmuxinator sessions and open tmux sessions for selection
function tx {
	local TMUXP_SESSIONS TMUX_SESSIONS SESSIONS SELECTED
	TMUXP_SESSIONS="$(fd 'yaml' .config/tmuxp -x echo "{/.}")"
	TMUX_SESSIONS="$(tmux list-sessions 2>/dev/null | sed -e "s/\(:.*\)//")"
	SESSIONS="$( (echo "$TMUXP_SESSIONS" && echo "$TMUX_SESSIONS" | grep -v "^$") | sort -u)"
	SELECTED="$(echo "$SESSIONS" | FZF_DEFAULT_OPTS="-x " fzf --tac --cycle -0 -1)"
	if [ -z ${SELECTED+x} ]; then
		return
	fi
	if echo "$TMUX_SESSIONS" | grep "$SELECTED" >/dev/null; then
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
	cols=$((COLUMNS / 3))
	sep='{::}'

	google_history="$HOME/.config/google-chrome/Default/History"
	open=xdg-open
	cp -f "$google_history" /tmp/h
	sqlite3 -separator $sep /tmp/h \
		"select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
		awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
		# fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
		fzf -x --multi | sed 's#.*\(https*://\)#\1#' | xargs $open >/dev/null 2>/dev/null
}

function fbhist {
	links="$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" 'select title,url from moz_places;' | fzf -x -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
	if [ "$links" != "" ]; then
		${BROWSER:-brave} --new-tab "$links"
	fi
}

function fncbookm {
	local links
	"$HOME/bin/get_nextcloud_bookmarks.sh"
	links="$(fzf -x -e -m <"$HOME/.cache/nextcloud_bookmarks.txt" | sed -e 's/.*http/http/')"
	if [ "$links" != "" ]; then
		${BROWSER:-brave} --new-tab "$links"
	fi
}

function fwiki {
	local files
	pushd "$WIKI_PATH" >/dev/null || return # directories should all be defined once via ENV vars.
	IFS=$'\n' files=$(fzf -x -e -m)
	vim "$files"
	popd >/dev/null || return
}

function fbookm {
	# links="$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" 'select title,url from moz_places;' | fzf -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
	IFS=$'\n' links=$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" "select '<a href=''' || url || '''>' || moz_bookmarks.title || '</a><br/>' as ahref from moz_bookmarks left join moz_places on fk=moz_places.id where url<>'' and moz_bookmarks.title<>''" | sed -e "s/^<a href='\(.*\)'>\(.*\)<\/a><br\/>/\2  |||  \1/" | fzf -x -e -0 -1 --no-sort --multi | sed -e 's/.*|||  //')
	if [ "$links" != "" ]; then
		${BROWSER:-brave} --new-tab "$links"
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
		print -s -- xdg-open "$file"
	xdg-open "$file"
}

fssh() {
	local cmd
	while ss -tl | grep $AUTOSSH_PORT >/dev/null; do
		export AUTOSSH_PORT=$(awk 'BEGIN { srand(); do r = rand()*32000; while ( r < 20000 ); printf("%d\n",r)  }' </dev/null)
	done
	cmd="$(grep -E ".*:[0-9];(auto)?ssh " "$XDG_CACHE_HOME/history" | sed -e 's/.*:[0-9];\(auto\)\?ssh /\1ssh /;s/"/\"/g' | sort -u | fzf)"
	print -s -- "$cmd"
	eval "$cmd"
}

function fdocker {
	if [[ -n "$1" ]]; then
		docker exec -it "$1" /bin/bash
		return
	fi
	lst=$(docker ps | grep -v IMAGE | awk '{printf "%s %-30s %s\n", $1, $2, $3}')
	choice=$(echo "$lst" | fzf --height=40% --no-sort --tiebreak=begin,index)
	if [[ -n "$choice" ]]; then
		printf "\n → %s\n" "$choice"
		choice=$(echo "$choice" | awk '{print $1}')
		docker exec -it "$choice" /bin/bash
	fi
}

frecipe() {
	curl -sG "https://plainoldrecipe.com/recipe" -d "url=${1}" | pandoc -f html -t markdown
}
