#!/bin/bash
#this file is called by .xinitrc to start some nice apps for dwm
HOST=$(hostname)
TERMI="${TERMINAL:-alacritty}"

xrdb -merge "${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources"
xrdb "${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources"

if [ "$HOST" == "work" ]; then
	# MONITOR=$(xrandr --listmonitors | grep -v "Monitors:" | sed 's/.*\s//;1q')
	# xrandr --output $MONITOR --mode 1920x1080 --rate 60
	VBoxClient --vmsvga
	VBoxClient --clipboard
	VBoxClient --draganddrop
	VBoxClient --seamless
	# VBoxClient --display
	VBoxClient --checkhostversion
	# nohup "$TERMI" --class "$TERMI - heiko@localhost" --title "$TERMI - heiko@localhost" &
	# nohup "$TERMI" --class "$TERMI - heiko@ed" --title "$TERMI - heiko@ed" &
	# nohup "$TERMI" --class "$TERMI - heiko@ed2" --title "$TERMI - heiko@ed2" &
	# nohup "$TERMI" --class "$TERMI - heiko@backup" --title "$TERMI - heiko@backup" &
	# else
	# nohup "$TERMI" --class "$TERMI - heiko@localhost" --title "$TERMI - heiko@localhost" &
	# nohup "$TERMI" --class "$TERMI - heiko@ed" --title "$TERMI - heiko@ed" &
	# nohup "$TERMI" --class "$TERMI - heiko@ed2" --title "$TERMI - heiko@ed2" &
	# nohup "$TERMI" --class "$TERMI - heiko@backup" --title "$TERMI - heiko@backup" &
fi

# sxhkd -c ${XDG_CONFIG_HOME:-$HOME/.config}/sxhkd/sxhkdrc &
"${XDG_CONFIG_HOME:-$HOME/.config}/polybar/launch.sh" "$HOST"
"${XDG_CONFIG_HOME:-$HOME/.config}/dunst/launch.sh" &
# feh --bg-fill "${XDG_CONFIG_HOME:-$HOME/.config}/wp.jpg" &
# udiskie -A -t &
# TODO: substitute by circadian
nohup xfce4-power-manager &
# nohup nextcloud &
# trayer --edge top --align center --expand false --width 5 --distance 20 &
if command -v clipmenud >/dev/null; then
	nohup clipmenud &
fi
if command -v brave >/dev/null; then
	nohup brave &
fi
# if command -v qutebrowser >/dev/null; then
# 	nohup qutebrowser &
# fi
# if command -v anki >/dev/null; then
# 	nohup anki &
# fi
# if command -v tbb >/dev/null; then
# 	nohup tbb &
# fi
if command -v signal-desktop >/dev/null; then
	nohup signal-desktop &
fi
if command -v onboard >/dev/null; then
	nohup onboard &
fi
if command -v xsuspender >/dev/null; then
	G_MESSAGES_DEBUG=xsuspender nohup xsuspender >/tmp/xsuspender.log &
	disown
fi
