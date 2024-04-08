#!/bin/bash
#this file is called by .xinitrc to start some nice apps for dwm
HOST=$(hostname)
# TERMI="${TERMINAL:-alacritty}"

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

"${XDG_CONFIG_HOME:-$HOME/.config}/dunst/launch.sh" &
# udiskie -A -t &
if [[ -z "${DISPLAY}" ]]; then
	"${XDG_CONFIG_HOME:-$HOME/.config}/polybar/launch.sh" "$HOST"
	# TODO: substitute by circadian
	nohup xfce4-power-manager &
	nohup "${XDG_CONFIG_HOME:-$HOME/.config}/polybar/launch.sh" &
	# trayer --edge top --align center --expand false --width 5 --distance 20 &
	if command -v clipmenud >/dev/null; then
		nohup clipmenud &
	fi
	if command -v onboard >/dev/null; then
		nohup onboard &
	fi
	if command -v xsuspender >/dev/null; then
		G_MESSAGES_DEBUG=xsuspender nohup xsuspender >/tmp/xsuspender.log &
		disown
	fi
fi
# if command -v brave >/dev/null; then
# 	nohup brave &
# fi
# if command -v qutebrowser >/dev/null; then
# 	nohup qutebrowser &
# fi
if command -v thunderbird >/dev/null; then
	nohup thunderbird &
fi
# if command -v signal-desktop >/dev/null; then
# 	nohup signal-desktop &
# fi
if command -v ntfy >/dev/null; then
	nohup ntfy subscribe --from-config &
fi
