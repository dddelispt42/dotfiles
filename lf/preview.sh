#!/bin/sh

case "$1" in
    *.pdf) pdftotext "$1" -;;
    *.md) mdcat "$1";;
    *) bat "$1";;
esac
