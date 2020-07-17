pwgen() {
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n "${1:-20}" | tr -d '\n'; echo
    # TODO: integrate "checkpwn pass"
}

# lfcd () {
#     tmp="$(mktemp)"
#     fid="$(mktemp)"
#     ~/git/lf/lf -command '$printf $id > '"$fid"'' -last-dir-path="$tmp" "$@"
#     id="$(cat "$fid")"
#     archivemount_dir="/tmp/__lf_archivemount_$id"
#     if [ -f "$archivemount_dir" ]; then
#         while read -r line; do
#             sudo umount "$line"
#             rmdir "$line"
#         done < "$archivemount_dir"
#         rm -f "$archivemount_dir"
#     fi
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         if [ -d "$dir" ]; then
#             if [ "$dir" != "$(pwd)" ]; then
#                 cd "$dir" || exit
#             fi
#         fi
#     fi
# }

n()
{
    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, export NNN_TMPFILE after the call to nnn
    export NNN_TMPFILE=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
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
    find . -type f -name "*" -print0 | \
        xargs -0  mplayer -vo dummy -ao dummy -identify 2>/dev/null | \
        perl -nle '/ID_LENGTH=([0-9\.]+)/ && (\$t +=\$1) && printf \"%02d:%02d:%02d\n\",\$t/3600,\$t/60%60,\$t%60' | \
        tail -n 1
    }

speedup() {
    </dev/null ffmpeg -i "$*" -filter atempo=1.5 "${*%%.mp3}-150.mp3"
}

youtube_watch() {
    # source: https://www.reddit.com/r/linux/comments/49u4f7/watch_youtube_videos_in_terminal/
    youtube-dl "'http://www.youtube.com/watch?v='$1" -o - | \
        mplayer -cache 122767 -vo aa:driver=curses -
    }

w3mimgdisplay() {
    # source: https://wiki.vifm.info/index.php?title=How_to_preview_images
    # Based on script by z3bra -- 2014-01-21
    W3MIMGDISPLAY="/usr/libexec/w3m/w3mimgdisplay"
    FONTH=15 # Size of one terminal row
    FONTW=7 # Size of one terminal column

    X=$1
    Y=$2
    COLUMNS=$3
    LINES=$4
    FILENAME=$5

    if [[ $# -le 4 ]] ; then
        echo "usage: $0 x y with height path"
        return 1
    fi

    read -r width height <<< "$(echo "5;$FILENAME" | "$W3MIMGDISPLAY")"
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
    while [[ $retval != 0 || $explanation == ""
        || $explanation == *"nothing appropriate"*
        || $explanation == *"unknown subject"* ]] ; do
        # 2>&1 prevents errors from beeing printed
        explanation="$(whatis "$(\ls /bin | shuf -n 1)" 2>&1)"
        retval=$?
    done
    printf "Did you know that:\n%s" "${explanation}"
}

supported_colors() {
    BLOCK=$(fill 5 "\u2588")
    for COLOR in {0..255}
    do
        for STYLE in "38;5"
        do
            TAG="\033[${STYLE};${COLOR}m"
            STR="${STYLE};${COLOR}"
            [[ $# -lt 1 ]] && echo -ne "${TAG}${STR}${BLOCK}${NONE}  " || echo -ne "${TAG}${BLOCK}${NONE}"
        done
        [[ $# -lt 1 ]] && echo
    done
    return 0
}

ctags4md() {
    ctags -f ./ctags -R --langdef=markdown --langmap=markdown:.md --regex-markdown="/^# ([a-zA-Z0-9]+)/\1/" --tag-relative=yes .
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

desyno() {
    wget -q -O- https://www.openthesaurus.de/synonyme/search\?q="$*"\&format=text/xml | sed 's/>/>\n/g' | \
        grep "<term term=" | cut -d \' -f 2 | paste -s -d , | sed 's/,/, /g' | fold -s -w "$(tput cols)";
}
geo() {
    curl "https://geo.risk3sixty.com/$1"
}
keys() {
    xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}
