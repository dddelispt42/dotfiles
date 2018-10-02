# Helper functions
en() { IFS=+; lang=en; Q="${*// /%20}"; curl -s "https://dict.leo.org/${lang}de/?search=${Q//+/%20}" | html2text | grep -EA 900 '^\*{5} ' | grep -B 900 '^Weitere Aktionen$';}
pt() { IFS=+; lang=pt; Q="${*// /%20}"; curl -s "https://dict.leo.org/${lang}de/?search=${Q//+/%20}" | html2text | grep -EA 900 '^\*{5} ' | grep -B 900 '^Weitere Aktionen$';}
# translate () {lang="ru"; text=$*; wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$text&sl=auto&tl=$lang" | sed 's/\[\[\[\"//' | cut -d \" -f 1}

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

