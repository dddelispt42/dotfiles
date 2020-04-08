#!/bin/sh
LINES=100

# dia
# docm
# epub
# icns
# ICO
# img
# iso
# potx
# ppsx
# psd
# pptm
# spt
# vcm
# vsd
# VSD
# xcf
# xlsm
# xps
# MS Office docs

if [ -d "$1" ]; then
    ls -la "$1"
    exit
fi

case "$1" in
    *.7z) 7z l "$1";;
    *.epub|*.EPUB) epub2txt "$1" | head -$LINES;;
    *.ch|*.y) bat -l c "$1" || cat "$1";;
        *.db|*.sqlite|*.DB|*.SQLITE) sqlite3 "$1" .schema | head -$LINES;;  # TODO improve and make more useful
    # *.jpg|*.jpeg|*.png) termimage -a truecolor -s 70x70 "$1";;
    *.jpg|*.JPG|*.jpeg|*.JPEG|*.png|*.PNG|*.tif|*.tiff|*.TIF|*.TIFF|.git|*.GIF) chafa "$1";;
    *.lz4|.LZ4) lz4 --list "$1";;
    *.md|*.MD|*.markdown) mdcat "$1" || glow "$1" || bat "$1" || highlight -O ansi --force "$1" || cat "$1";;
    *.odt|*.ODT|*.ods|*.ODS|*.odp|*.ODP) odt2txt "$1";;
    *.ogv|*.OGV|*.mp4|*.MP4|*.mkv|*.MKV|*.avi|*.AVI|*.swf|*.SWF|*.flv|*.FLV|*.mov|*.MOV|*.mpg|*.MPG|*.webm|*.WEBM) mediainfo "$1";;
    *.pdf|*.PDF) pdftotext "$1" -;;
    *.rar|*.RAR) unrar l "$1";;
    *.smd|*.gliffy) bat -l json "$1" || cat "$1";;
    *.tar*|*.TAR*) tar tf "$1";;
    *.tex|*.bbl|*.bib|*.vrb|*.toc|*.snm|*.nav) bat -l tex "$1" || cat "$1";;
    *.tmpl) bat -l html "$1" || cat "$1";;
    *.wadl|*.proj) bat -l xml "$1" || cat "$1";;
    *.zip|*.zipx|*.ZIP|*.ZIPX) unzip -l "$1";;
    *) bat --color always "$1" || highlight -O ansi --force "$1" || cat "$1";;
esac
