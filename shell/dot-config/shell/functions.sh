# shellcheck disable=SC2148

pwgen() {
	strings /dev/urandom | grep -o '[[:alnum:]]' | head -n "${1:-20}" | tr -d '\n'
	echo
}

cht() {
	curl "cht.sh/$1"
}

n() {
	# The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
	# To cd on quit only on ^G, export NNN_TMPFILE after the call to nnn
	export NNN_TMPFILE=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd

	nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		# shellcheck disable=SC1090
		. "$NNN_TMPFILE"
		rm "$NNN_TMPFILE"
	fi
}

yt2mp3() {
	youtube-dl --extract-audio --audio-format mp3 --add-metadata --embed-thumbnail "$1"
}

friday13th() {
	for y in $(seq 1946 2028); do
		echo -n "$y -> "
		for m in $(seq 1 12); do
			NDATE=$(date --date "$y-$m-13" +%w)
			if [ "$NDATE" -eq 5 ]; then
				PRINTME=$(date --date "$y-$m-13" +%B)
				echo -n "$PRINTME "
			fi
		done
		echo
	done
}

vimprofile() {
	vim --startuptime /tmp/vim.log "$@" && vim /tmp/vim.log
}

compress_pdf() {
	gs -o "$2" -sDEVICE=pdfwrite -dPDFSETTINGS=/screen -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH "$1"
}

cut_video() {
	ffmpeg -i "$1" -ss "$2" -to "$3" -c copy cut.mp4
}

concat_video() {
	ffmpeg -i "$1" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate1.ts
	ffmpeg -i "$2" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate2.ts
	ffmpeg -i "concat:intermediate1.ts|intermediate2.ts" -c copy -bsf:a aac_adtstoasc concat.mp4 && rm intermediate1.ts intermediate2.ts
}

repair_pdf() {
	gs -o "$2" -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress "$1"
}

ptime() {
	find . -type f -name "*" -print0 |
		xargs -0 mplayer -vo dummy -ao dummy -identify 2>/dev/null |
		perl -nle '/ID_LENGTH=([0-9\.]+)/ && (\$t +=\$1) && printf \"%02d:%02d:%02d\n\",\$t/3600,\$t/60%60,\$t%60' |
		tail -n 1
}

speedup() {
	ffmpeg </dev/null -i "$*" -filter atempo=1.5 "${*%%.mp3}-150.mp3"
}

youtube_watch() {
	# source: https://www.reddit.com/r/linux/comments/49u4f7/watch_youtube_videos_in_terminal/
	youtube-dl "'http://www.youtube.com/watch?v='$1" -o - |
		mplayer -cache 122767 -vo aa:driver=curses -
}

w3mimgdisplay() {
	# source: https://wiki.vifm.info/index.php?title=How_to_preview_images
	# Based on script by z3bra -- 2014-01-21
	W3MIMGDISPLAY="/usr/libexec/w3m/w3mimgdisplay"
	FONTH=15 # Size of one terminal row
	FONTW=7  # Size of one terminal column

	X=$1
	Y=$2
	COLUMNS=$3
	LINES=$4
	FILENAME=$5

	if [[ $# -le 4 ]]; then
		echo "usage: $0 x y with height path"
		return 1
	fi

	read -r width height <<<"$(echo "5;$FILENAME" | "$W3MIMGDISPLAY")"
	if [ -z "$width" ] || [ -z "$height" ]; then
		echo 'Error: Failed to obtain image size.'
		return 1
	fi

	x=$((FONTW * X))
	y=$((FONTH * Y))

	max_width=$((FONTW * COLUMNS))
	max_height=$((FONTH * LINES))

	if [ "$width" -gt "$max_width" ]; then
		height=$((height * max_width / width))
		width=$max_width
	fi
	if [ "$height" -gt "$max_height" ]; then
		width=$((width * max_height / height))
		height=$max_height
	fi

	w3m_command="0;1;$x;$y;$width;$height;;;;;$FILENAME\n4;\n3;"

	echo -e "$w3m_command" | $W3MIMGDISPLAY
}

explain_command() {
	local retval=1
	local explanation=""
	while [[ $retval != 0 || $explanation == "" ||
		$explanation == *"nothing appropriate"* ||
		$explanation == *"unknown subject"* ]]; do
		explanation="$(whatis "$(fd '.*' /bin --max-depth 1 -x echo "{/}" | shuf -n 1)" 2>&1)"
		retval=$?
	done
	printf "Did you know that:\n%s" "${explanation}"
}

supported_colors() {
	BLOCK=$(fill 5 "\u2588")
	for COLOR in {0..255}; do
		# shellcheck disable=SC2043
		for STYLE in "38;5"; do
			TAG="\033[${STYLE};${COLOR}m"
			STR="${STYLE};${COLOR}"
			[[ $# -lt 1 ]] && echo -ne "${TAG}${STR}${BLOCK}${NONE}  " || echo -ne "${TAG}${BLOCK}${NONE}"
		done
		[[ $# -lt 1 ]] && echo
	done
	return 0
}

ctags4md() {
	ctags -f ./tags -R --langdef=markdown --langmap=markdown:.md --regex-markdown="/^# ([a-zA-Z0-9]+)/\1/" --tag-relative=yes .
}

# Create a temporary directory, with current time until minutes, and
# link /tmp/tempdir to it
tempdirnew() {
	DIR="/tmp/tmp.$(date +%F/%H-%M-%S)"
	mkdir -p "$DIR"
	if [ -d /tmp/tempdir ]; then
		rm -f /tmp/tempdir.old
		mv /tmp/tempdir /tmp/tempdir.old
	fi
	ln -s "$DIR" /tmp/tempdir
	cd /tmp/tempdir || exit 1
	echo "$DIR"
}

# Jump to tempdir
tempdir() {
	if [ -d /tmp/tempdir ]; then
		cd /tmp/tempdir || exit 1
	else
		tempdirnew
	fi
}

public_ip() {
	curl https://ipinfo.io/ip
}

waitmake() {
	while true; do
		inotifywait -e modify -r .
		make "$@"
		sleep 0.1
	done
}

latexwaitmake() {
	yes q | waitmake "$@"
}

pdfsmaller() {
	case $1 in
	vlow)
		SET=screen
		;;
	low)
		SET=ebook
		;;
	high)
		SET=printer
		;;
	supercolor)
		SET=prepress
		;;
	*)
		echo "Usage: "
		echo "  $0 [vlow|low|high|supercolor] input.pdf output.pdf"
		echo ""
		echo "Types:"
		echo "  vlow       : 72 dpi images : screen-view-only quality"
		echo "  low        : 150 dpi images"
		echo "  high       : 300 dpi images"
		echo "  supercolor : 300 dpi images : color preserving"
		return
		;;
	esac
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/"${SET}" -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${3}" "${2}"
}

# Colorized wdiff
cwdiff() {
	wdiff -n -w $'\033[1;31m' -x $'\033[0m' -y $'\033[1;32m' -z $'\033[0m' -s "$1" "$2"
}

geo() {
	curl "https://geo.risk3sixty.com/$1"
}

keys() {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# Usage: randomSE [number]
randomSE() {
	jq '..|.short?' "${HOME}/dev/work/nms-se-tools/plpbot/config/seTeam.json" | grep -v 'null' | sort -R | tail -"${1:-1}"
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
	local syntax="${1:-python}"
	shift
	nvim -c \
		"let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}
ggs() {
	git global scan
	git global list | grep -v "/home/heiko/Nextcloud" | grep -v "pt-rdl4002-dev" | grep -v ".cache/paru" | grep -v "/home/heiko/.local/share/Trash" >"$HOME/.cache/git-global/repos_new.txt"
	mv -f "$HOME/.cache/git-global/repos_new.txt" "$HOME/.cache/git-global/repos.txt"
	git global | $PAGER
}
function dy { dig +noall +answer +additional "$1" @dns.toys; }
function deredirct_url { curl --silent -I -L "$1" | grep -i location; }

su() {
	(
		INHIBIT_THEME_HIST=1 theme.sh red-alert
		trap 'theme.sh "$(theme.sh -l|tail -n1)"' INT
		env su "$@"
		theme.sh "$(theme.sh -l | tail -n1)"
	)
}

# if command -v theme.sh >/dev/null; then
# 	sudo() {
# 		(
# 			pid=$(exec sh -c 'echo "$PPID"')
#
# 			# If the command takes less than .2s, don't change the theme.
# 			# We could also just match on 'su' and ignore everything else,
# 			# but this also accomodates other long running commands
# 			# like 'sudo sleep 5s'. Modify to taste.
#
# 			(
# 				sleep .2s
# 				ps -p "$pid" >/dev/null && INHIBIT_THEME_HIST=1 theme.sh red-alert
# 			) &
#
# 			trap 'theme.sh "$(theme.sh -l|tail -n1)"' INT
# 			env sudo "$@"
# 			theme.sh "$(theme.sh -l | tail -n1)"
# 		)
# 	}
#
# 	ssh() {
# 		# A tiny ssh wrapper which extracts a theme from ~/.config/ssh_themes
# 		# and applies it for the duration of the current ssh command.
# 		# Each line in ~/.config/ssh_themes has the format:
# 		#     <hostname>: <theme>.
#
# 		# Restoration relies on the fact that you are using theme.sh to manage
# 		# the current theme.  (that is, you set the theme in your bashrc.)
#
# 		# This can probably be made more robust. It is just a small demo
# 		# of what is possible.
#
# 		touch ~/.config/ssh_themes
#
# 		host="$(echo "$@" | awk '{gsub(".*@","",$NF);print $NF}')"
# 		theme="$(awk -vhost="$host" -F': *' 'index($0, host":") == 1 {print $2}' <~/.config/ssh_themes)"
#
# 		if [ -z "$theme" ]; then
# 			env ssh "$@"
# 			return
# 		fi
#
# 		INHIBIT_THEME_HIST=1 theme.sh "$theme"
# 		trap 'theme.sh "$(theme.sh -l|tail -n1)"' INT
# 		env ssh "$@"
# 		theme.sh "$(theme.sh -l | tail -n1)"
# 	}
# fi

vicd() {
	local dst
	dst="$(command vifm --choose-dir - "$@")"
	if [ -z "$dst" ]; then
		echo 'Directory picking cancelled/failed'
		return 1
	fi
	cd "$dst" || true
}

function y() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd" || true
	fi
	rm -f -- "$tmp"
}

git_default_branch() {
	(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') 2>/dev/null
}

cdwt() {
	cd "$(git worktree list | fzf -0 -1 | awk '{print $1;}')" || true
}
