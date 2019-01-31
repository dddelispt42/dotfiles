function home() {
    while : ; do
        ssh -t home "ssh 192.168.1.99"
        if [ $? -eq 0 ] ; then
            break
        fi
    done
}

function cssh() {
    while : ; do
        # echo -ne "\033]0;${USER}@${1}\007"
        sleep 30 &
        ssh -t $1 tmux a
        wait
        if [ $? -eq 0 ] ; then
            break
        fi
    done
}

function yt2mp3() {
    youtube-dl --extract-audio --audio-format mp3 --add-metadata --embed-thumbnail "$1"
}

function friday13th() {
    for y in $(seq 1946 2028); do echo -n "$y -> "; for m in $(seq 1 12); do NDATE=$(date --date "$y-$m-13" +%w); if [ $NDATE -eq 5 ]; then PRINTME=$(date --date "$y-$m-13" +%B);echo -n "$PRINTME "; fi; done; echo; done
}

function vimprofile() {
    vim --startuptime /tmp/vim.log "$@" && vim /tmp/vim.log
}

function compress-pdf() {
    gs -o "$2" -sDEVICE=pdfwrite -dPDFSETTINGS=/screen -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH "$1"
}

function cut-video() {
    ffmpeg -i "$1" -ss "$2" -to "$3" -c copy cut.mp4
}

function concat-video() {
    ffmpeg -i "$1" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate1.ts
    ffmpeg -i "$2" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate2.ts
    ffmpeg -i "concat:intermediate1.ts|intermediate2.ts" -c copy -bsf:a aac_adtstoasc concat.mp4 && rm intermediate1.ts intermediate2.ts
}
function repair-pdf() {
    gs -o "$2" -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress "$1"
}
ptime() {
    find -type f -name \"*\" -print0 | \
        xargs -0  mplayer -vo dummy -ao dummy -identify 2>/dev/null | \
        perl -nle '/ID_LENGTH=([0-9\.]+)/ && (\$t +=\$1) && printf \"%02d:%02d:%02d\n\",\$t/3600,\$t/60%60,\$t%60' | \
        tail -n 1
    }
r() {
    [[ "$RANGER_LEVEL" ]] && exit || ranger
}
speedup() {
    </dev/null ffmpeg -i "$*" -filter atempo=1.5 "${*%%.mp3}-150.mp3"
}
function fix_nc_conflicts() {
    for dupli in $(ls *_conflict-*); do
        vimdiff $(echo $dupli | sed -e 's/_conflict-.*\././') $dupli
        rm -i $dupli
    done
}
function youtube_watch() {
    # source: https://www.reddit.com/r/linux/comments/49u4f7/watch_youtube_videos_in_terminal/
    youtube-dl 'http://www.youtube.com/watch?v='$1 -o - | \
        mplayer -cache 122767 -vo aa:driver=curses -
    }
function w3mimgdisplay() {
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

    read width height <<< `echo "5;$FILENAME" | $W3MIMGDISPLAY`
    if [ -z "$width" -o -z "$height" ]; then
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
function explain_command() {
    local retval=1
    local explanation=""
    while [[ $retval != 0 || $explanation == ""
        || $explanation == *"nothing appropriate"*
        || $explanation == *"unknown subject"* ]] ; do
        # 2>&1 prevents errors from beeing printed
        local explanation=$(whatis $(ls /bin | shuf -n 1) 2>&1)
        local retval=$?
    done
    echo "Did you know that:\n"$explanation
}
function supported_colors() {
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
