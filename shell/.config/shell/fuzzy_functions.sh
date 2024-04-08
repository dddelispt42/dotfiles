# shellcheck disable=2148
# TODO: fix JIRA fuzzy search
# TODO: fix fgr fuzzy search - just one function (see ff)
# TODO: merge __handlexxx with caller
# TODO: fix file/path yank (on X only - Wayland works)
# TODO: check TODOs in file

# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extension mp3
# fm rm # To rm files in current directory
f() {
	# shellcheck disable=2296
	sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
	# shellcheck disable=2128,2145
	test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}
# Like f, but not recursive.
fm() {
	f "$@" --max-depth 1
}

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
		echo "$ids" | head -1 | xclip
	else
		echo "$ids" | head -1 | xclip
	fi
}

fja() {
	local output
	output=$(cat "${XDG_CACHE_HOME:-$HOME/.cache}"/JiraIssueCache*.issues | FZF_DEFAULT_OPTS="--reverse -x --multi --height 100%" fzf-tmux --prompt="Select issue(s) [C-brOwser/Urls/Print/Yank]> " -x -0 -m --expect=ctrl-o,ctrl-u,ctrl-p,ctrl-y) || return
	__handle_jira_issues "$output"
}

fj() {
	local output
	output=$(cat "${XDG_CACHE_HOME:-$HOME/.cache}"/JiraIssueCache*.issues | grep -vE "( Closed| Done| Descope| Resolve| Rejecte)" | FZF_DEFAULT_OPTS="--reverse -x --multi --height 100%" fzf-tmux --prompt="Select issue(s) [C-brOwser/Url/Print/Yank]> " -x -0 -m --expect=ctrl-o,ctrl-u,ctrl-p,ctrl-y) || return
	__handle_jira_issues "$output"
}

# See man pages
fman() {
	man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}
# Install packages using yay (change to pacman/AUR helper of your choice)
fpin() {
	local cmd
	cmd=pacman
	if paru --version >/dev/null; then cmd=paru; fi
	$cmd -Sql | fzf -q "$1" -m --preview "$cmd -Si {1}" | xargs -ro sudo $cmd -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
fpun() {
	local cmd
	cmd=pacman
	if paru --version >/dev/null; then cmd=paru; fi
	$cmd -Qq | fzf -q "$1" -m --preview "$cmd -Qi {1}" | xargs -ro sudo $cmd -Rns
}

__run_with_history() {
	print -s -- "$1 $(for item in "${@:2}"; do printf "%s\t" "$(realpath "$item")"; done)"
	"$@"
}
__handle_files() {
	local key files
	key=$(echo "$1" | head -1)
	files=$(echo "$1" | tail -n +2)
	if [[ -n $files ]]; then
		if [ "$key" = ctrl-o ]; then
			echo "$files" | while read -r line; do
				__run_with_history xdg-open "$line"
			done
		elif [ "$key" = ctrl-p ]; then
			echo "$files" | while read -r line; do
				__run_with_history "${XDG_CONFIG_HOME:-$HOME/.config}/lf/preview.sh" "$line"
			done
		elif [ "$key" = ctrl-e ]; then
			print -s -- "${EDITOR:-vim}" "$(echo "$files" | while read -r line; do echo "$line"; done)"
			# shellcheck disable=SC2046
			"${EDITOR:-vim}" $(echo "$files" | while read -r line; do echo "$line"; done)
		elif [ "$key" = ctrl-y ]; then
			if [[ -n "${WAYLAND_DISPLAY}" ]]; then
				echo "$files" | while read -r line; do echo "$line"; done | wl-copy
			elif [[ -n "${DISPLAY}" ]]; then
				echo "$files" | while read -r line; do echo "$line"; done | xclip
			else
				echo "$files" | while read -r line; do echo "$line"; done
			fi
		else
			first_entry="$(echo "$files" | head -1)"
			if [ -d "$first_entry" ]; then
				cd "$first_entry" || return
				return
			fi
			# shellcheck disable=SC2046
			__run_with_history "${EDITOR:-vim}" $(echo "$files" | while read -r line; do echo "$line"; done)
		fi
	fi
}
ff() {
	local output
	IFS=$'\n' output=$(fzf-tmux --query="$1" --ansi \
		--header="Ctrl-[s]elect/[u]nselect/[t]oggle/Pre[v]iew- [E]DIT/[o]pen/[p]ager/[x]sort/[y]ank/[h]idden/[d]irOnly/[r]eset" \
		--bind='ctrl-s:select-all' \
		--bind='ctrl-u:deselect-all' \
		--bind='ctrl-t:toggle-all' \
		--bind="ctrl-h:change-prompt((Hidden]▶)+reload(eval $FZF_DEFAULT_COMMAND_HIDDEN)" \
		--bind="ctrl-d:change-prompt([Directories]▶)+reload(eval $FZF_DEFAULT_COMMAND_DIR)" \
		--bind="ctrl-f:change-prompt([Files]▶)+reload(eval $FZF_DEFAULT_COMMAND)" \
		--bind='ctrl-v:toggle-preview' \
		--bind='ctrl-x:toggle-sort' \
		--expect='ctrl-o,ctrl-e,ctrl-p,ctrl-y') || return
	__handle_files "$output"
}
fa() {
	FZF_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND_HIDDEN" ff "$@"
}
fcd() {
	FZF_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND_DIR" ff "$@"
}
f.() {
	pushd "${DOTFILES:-$HOME/dev/$USER/dotfiles/}" >/dev/null || return
 	ff "$@"
	popd >/dev/null || return
}
floc() {
	FZF_DEFAULT_COMMAND="locate -Ai $*" ff
}
fgr() {
	local output
	IFS=$'\n' output=$(rg --color=always --vimgrep --line-number --no-heading --smart-case "${*:-}" | fzf-tmux --query "${*:-}" --ansi \
		--header="Ctrl-[s]elect/[u]nselect/[t]oggle/Pre[v]iew- [E]DIT/[o]pen/[p]ager/[x]sort/[y]ank/[h]idden/[d]irOnly/[r]eset" \
		--bind='ctrl-s:select-all' \
		--bind='ctrl-u:deselect-all' \
		--bind='ctrl-t:toggle-all' \
		--bind='ctrl-v:toggle-preview' \
		--bind='ctrl-x:toggle-sort' \
		--expect="ctrl-o,ctrl-e,ctrl-p,ctrl-y") || return
	# shellcheck disable=SC2046
	__run_with_history "${EDITOR:-vim}" $(echo "$output" | while read -r line; do echo "$line" | sed -e 's/\x1b\[[0-9;]*m//g' | sed -e 's/\(.*\):\([0-9]\+\):[0-9]\+.*/\1:\2/'; done)
}

fgi() {
	# Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)
	rm -f /tmp/rg-fzf-{r,f}
	RG_PREFIX="rg -uuu --column --line-number --no-heading --color=always --smart-case "
	INITIAL_QUERY="${*:-}"
	: | fzf --ansi --disabled --query "$INITIAL_QUERY" \
		--header="Ctrl-[R]g/[F]zf/[s]elect/[u]nselect/[t]oggle/Pre[v]iew- [E]DIT/[o]pen/[p]ager/[x]sort/[y]ank/[h]idden/[d]irOnly/[r]eset" \
		--bind='ctrl-s:select-all' \
		--bind='ctrl-u:deselect-all' \
		--bind='ctrl-t:toggle-all' \
		--bind='ctrl-v:toggle-preview' \
		--bind='ctrl-x:toggle-sort' \
		--bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
		--bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. rg> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--prompt '1. rg> ' \
		--delimiter : \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
		--expect="ctrl-o,ctrl-e,ctrl-p,ctrl-y" \
		--bind 'enter:become(nvim {1} +{2})' || return

	# TODO: allow multiselection (see fgra)
}

function __handle_fuzzy_grep {
	local cmd resultlist
	cmd=rg
	if [ "$1" -eq "0" ]; then
		# echo "${cmd:-rg} --vimgrep --line-number $2"
		resultlist=$(${cmd:-rg} --vimgrep --line-number "$2" 2>/dev/null | fzf-tmux -x -0 -1 -m)
	else
		command -v rga >/dev/null && cmd=rga
		# echo "${cmd:-rg} --vimgrep --line-number -uuu $2"
		resultlist=$(${cmd:-rg} --vimgrep --line-number -uuu "$2" 2>/dev/null | fzf-tmux -x -0 -1 -m)
	fi
	if [ "$resultlist" != "" ]; then
		# shellcheck disable=SC2046
		print -s -- "${EDITOR:-vim}" $(echo "$resultlist" | while read -r line; do echo "$line" | awk -F : '{print $1 ":" $2;}'; done)
		# shellcheck disable=SC2046
		"${EDITOR:-vim}" $(echo "$resultlist" | while read -r line; do echo "$line" | awk -F : '{print $1 ":" $2;}'; done)
	fi
}

# fuzzy grep open via ag
function fgra {
	__handle_fuzzy_grep 1 "$@"
}

# fuzzy grep open via ag
# function fgr {
# 	__handle_fuzzy_grep 0 "$@"
# }

# fkill - kill process
function fkill {
	local pid
	pid=$(ps -ef | sed 1d | FZF_DEFAULT_OPTS="--reverse" fzf-tmux -x -m | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo "$pid" | xargs kill -"${1:-9}"
	fi
}

# fbr - checkout git branch (including remote branches)
#   - sorted by most recent commit
#   - limit 30 last branches
fbr() {
  local branches
  local num_branches
  local branch
  local target

  branches="$(
    git for-each-ref \
      --count=30 \
      --sort=-committerdate \
      refs/heads/ \
      --format='%(refname:short)'
  )" || return

  num_branches="$(wc -l <<< "$branches")"

  branch="$(
    echo "$branches" \
      | fzf-tmux -d "$((2 + "$num_branches"))" +m
  )" || return

  target="$(
    echo "$branch" \
      | sed "s/.* //" \
      | sed "s#remotes/[^/]*/##"
  )" || return

  git checkout "$target"
}
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out
  local q
  local k
  local sha

  while out="$(
    git stash list --pretty='%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs' \
      | fzf -0 \
          --ansi \
          --no-sort \
          --query="$q" \
          --print-query \
          --expect=ctrl-d,ctrl-b
  )"; do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff "$sha"
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" "$sha"
      break
    else
      git stash show -p "$sha"
    fi
  done
}

# TODO: all above there fully tested - below not!!!

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
	IFS=$'\n' fileparam=$(awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' $tagfile | awk '{print $1 "|" $2 "|" $3;}' | sed -e 's/\(.*\)|\(.*\)|\(.*\)/\1  \|\2                                       \|\3/' | sed -e 's/\(.*\)|\(.\{0,40\}\).*|\(.*\)/\1\2\3/' | fzf-tmux -x -m -0 -1 | while read -r line; do echo "$tagfiledir/$(echo "$line" | awk '{print $3;}')"; done)
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
	TMUXP_SESSIONS="$(fd 'yaml' "${XDG_CONFIG_HOME:-$HOME/.config}"/tmuxp -x echo "{/.}")"
	TMUX_SESSIONS="$(tmux list-sessions 2>/dev/null | sed -e "s/\(:.*\)//")"
	SESSIONS="$( (echo "$TMUXP_SESSIONS" && echo "$TMUX_SESSIONS" | grep -v "^$") | sort -u)"
	SELECTED="$(echo "$SESSIONS" | FZF_DEFAULT_OPTS="--reverse -x " fzf-tmux --tac --cycle -0 -1)"
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

	target=$(echo "$panes" | grep -v "$current_pane" | fzf-tmux -x +m --reverse) || return

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
		fzf-tmux -x --multi | sed 's#.*\(https*://\)#\1#' | xargs $open >/dev/null 2>/dev/null
}

function fbhist {
	links="$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" 'select title,url from moz_places;' | fzf-tmux -x -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
	if [ "$links" != "" ]; then
		${BROWSER:-brave} --new-tab "$links"
	fi
}

function fncbookm {
	local links
	"$HOME/bin/get_nextcloud_bookmarks.sh"
	links="$(fzf-tmux -x -e -m <"$HOME/.cache/nextcloud_bookmarks.txt" | sed -e 's/.*http/http/')"
	if [ "$links" != "" ]; then
		${BROWSER:-brave} --new-tab "$links"
	fi
}

function fwiki {
	local files
	pushd "$WIKI_PATH" >/dev/null || return # directories should all be defined once via ENV vars.
	IFS=$'\n' files=$(fzf-tmux -x -e -m)
	vim "$files"
	popd >/dev/null || return
}

function fbookm {
	# links="$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" 'select title,url from moz_places;' | fzf -e -0 -1 --no-sort --multi | sed -e 's/.*|//')"
	IFS=$'\n' links=$(sqlite3 "$FIREFOX_PROFILE/places.sqlite" "select '<a href=''' || url || '''>' || moz_bookmarks.title || '</a><br/>' as ahref from moz_bookmarks left join moz_places on fk=moz_places.id where url<>'' and moz_bookmarks.title<>''" | sed -e "s/^<a href='\(.*\)'>\(.*\)<\/a><br\/>/\2  |||  \1/" | fzf-tmux -x -e -0 -1 --no-sort --multi | sed -e 's/.*|||  //')
	if [ "$links" != "" ]; then
		${BROWSER:-brave} --new-tab "$links"
	fi
}

# frga() {
# 	RG_PREFIX="rga --files-with-matches"
# 	local file
# 	file="$(
# 		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
# 			fzf-tmux --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
# 			--phony -q "$1" \
# 			--bind "change:reload:$RG_PREFIX {q}" \
# 			--preview-window="70%:wrap"
# 	)" &&
# 		echo "opening $file" &&
# 		print -s -- xdg-open "$file"
# 	xdg-open "$file"
# }

# fssh() {
# 	local cmd
# 	while ss -tl | grep "$AUTOSSH_PORT" >/dev/null; do
# 		export AUTOSSH_PORT="$(awk 'BEGIN { srand(); do r = rand()*32000; while ( r < 20000 ); printf("%d\n",r)  }')"
# 	done
# 	cmd="$(grep -E ".*:[0-9];(auto)?ssh " "$XDG_CACHE_HOME/history" | sed -e 's/.*:[0-9];\(auto\)\?ssh /\1ssh /;s/"/\"/g' | sort -u | fzf-tmux)"
# 	print -s -- "$cmd"
# 	eval "$cmd"
# }

# function fdocker {
# 	if [[ -n "$1" ]]; then
# 		docker exec -it "$1" /bin/bash
# 		return
# 	fi
# 	lst=$(docker ps | grep -v IMAGE | awk '{printf "%s %-30s %s\n", $1, $2, $3}')
# 	choice=$(echo "$lst" | fzf-tmux --height=40% --no-sort --tiebreak=begin,index)
# 	if [[ -n "$choice" ]]; then
# 		printf "\n → %s\n" "$choice"
# 		choice=$(echo "$choice" | awk '{print $1}')
# 		docker exec -it "$choice" /bin/bash
# 	fi
# }

# TODO: add all possible operations to FZF
fdc () {
	local cid
	cid=$(docker ps --all | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker stop "$cid"
}
fdi() {
	docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}
