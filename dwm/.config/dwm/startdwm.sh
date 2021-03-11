#!/bin/bash
#this file is called by .xinitrc to start some nice apps for dwm
HOST=$(hostname)

if [ "$HOST" == "work" ]; then
    # MONITOR=$(xrandr --listmonitors | grep -v "Monitors:" | sed 's/.*\s//;1q')
    # xrandr --output $MONITOR --mode 1920x1080 --rate 60
    VBoxClient --clipboard
    VBoxClient --draganddrop
    VBoxClient --seamless
    # VBoxClient --display
    VBoxClient --checkhostversion
    # VBoxClient --vmsvga-x11
fi
xrdb -merge ${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources
xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources
# sxhkd -c ${XDG_CONFIG_HOME:-$HOME/.config}/sxhkd/sxhkdrc &
# ${XDG_CONFIG_HOME:-$HOME/.config}/polybar/launch.sh "$HOST"
# ${XDG_CONFIG_HOME:-$HOME/.config}/dunst/launch.sh
# feh --bg-fill ${XDG_CONFIG_HOME:-$HOME/.config}/wall.png &
# udiskie -A -t &
# st &
# st &
# xfce4-power-manager &
# clipmenud &

while true; do
    dwm || exit
done
