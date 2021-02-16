#!/bin/bash
#this file is called by .xinitrc to start some nice apps for dwm
HOST=$(hostname)

if [ "$HOST" == "manjaro" ]; then
#     MONITOR=$(xrandr --listmonitors | grep -v "Monitors:" | sed 's/.*\s//;1q')
#     xrandr --output $MONITOR --mode 1920x1080 --rate 60
    ~/.config/autostart/VBoxClient.sh
fi
# xrdb -merge ~/.Xresources &
xrdb ~/.Xresources
# sxhkd -c ~/.config/sxhkd/sxhkdrc &
# ~/.config/polybar/launch.sh "$HOST"
# ~/.config/dunst/launch.sh
# feh --bg-fill ~/.config/wall.png &
# udiskie -A -t &
# st &
# st &
# xfce4-power-manager &
# clipmenud &

while true; do
    dwm || exit
done
