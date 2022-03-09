#!/bin/sh

# dia
# docm
# epub
# icns
# ICO
# img
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

_open() {
	case "$1" in
	*.tar.bz | *.tar.bz2 | *.tbz | *.tbz2 | *.tar.gz | *.tgz | *.tar.xz | *.txz | *.zip | *.rar | *.iso)
		mntdir="$1-archivemount"
		[ ! -d "$mntdir" ] && {
			mkdir "$mntdir"
			archivemount "$1" "$mntdir"
			# TODO: get the lf id  <03-05-20, Heiko Riemer> #
			echo "$mntdir" >>"/tmp/__lf_archivemount_$id"
		}
		lf -remote "send $id cd \"$mntdir\""
		lf -remote "send $id reload"
		;;
	esac
	case $(file --mime-type "$1" -b) in
	text/troff) man ./ "$1" ;;
	text/*) "$EDITOR" "$1" ;;
	image/x-xcf | image/svg+xml) setsid gimp "$1" >/dev/null 2>&1 & ;;
	application/epub+zip) setsid zathura "$1" ;;
	image/*) setsid sxiv -ai >/dev/null 2>&1 & ;;
	audio/*) setsid umpv "$1" ;;
	video/*) setsid umpv "$1" -quiet >/dev/null 2>&1 & ;;
	# audio/*) setsid vlc "$1" ;;
	# video/*) setsid vlc "$1" >/dev/null 2>&1 & ;;
	application/pdf) setsid zathura "$1" >/dev/null 2>&1 & ;;
	*) setsid "${OPENER:-xdf-open}" "$1" >/dev/null 2>&1 & ;;
	esac
}

if [ $# -eq 0 ]; then
	exit
elif [ $# -eq 1 ]; then
	if [ -d "$1" ]; then
		cd "$1" || exit
	else
		_open "$1"
	fi
else
	for arg in "$@"; do
		_open "$arg"
		sleep 1
	done
fi
