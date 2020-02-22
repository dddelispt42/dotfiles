#!/bin/sh

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *.jpg|.jpeg|*.png) termimage "$1";;
    *.md) mdcat "$1";;
    *.mp4|*.mkv) mediainfo "$1";;
    *.sh) bat "$1";;
    *.py) bat "$1";;
    *) bat "$1" || highlight -O ansi "$1" || cat "$1";;
esac
