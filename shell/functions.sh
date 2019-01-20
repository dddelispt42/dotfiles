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
function ctags4md() {
    ctags -f ./ctags -R --langdef=markdown --langmap=markdown:.md --regex-markdown="/^# ([a-zA-Z0-9]+)/\1/" --tag-relative=yes .
}
# Create a temporary directory, with current time until minutes, and
# link /tmp/tempdir to it
function tempdirnew() {
    DIR="/tmp/tmp.$(date +%F/%H-%M-%S)"
    mkdir -p "$DIR"
    if [ -d /tmp/tempdir ]; then
	rm -f /tmp/tempdir.old
	mv /tmp/tempdir /tmp/tempdir.old
    fi
    ln -s "$DIR" /tmp/tempdir
    cd /tmp/tempdir
    echo "$DIR"
}
# Jump to tempdir
function tempdir() {
    if [ -d /tmp/tempdir ]; then
	cd /tmp/tempdir
    else
	tempdirnew
    fi
}

function public-ip() {
    curl https://ipinfo.io/ip
}

function waitmake() {
    while true; do
	inotifywait -e modify -r .
	make "$@"
	sleep 0.1
    done
}

function latexwaitmake() {
    yes q | waitmake
}

function pdfsmaller() {
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
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/${SET} -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${3} ${2}
}

# Colorized wdiff
function cwdiff() {
    wdiff -n -w $'\033[1;31m' -x $'\033[0m' -y $'\033[1;32m' -z $'\033[0m' -s "$1" "$2"
}
