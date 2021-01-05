#!/bin/bash
#this file is called by .xinitrc to start some nice apps for dwm
HOST=$(hostname)

if [ "$HOST" == "manjaro" ]; then
#     MONITOR=$(xrandr --listmonitors | grep -v "Monitors:" | sed 's/.*\s//;1q')
#     xrandr --output $MONITOR --mode 1920x1080 --rate 60
    ~/.config/autostart/VBoxClient.sh
fi
xrdb -merge ~/.Xresources &
xrdb ~/.Xresources
# sxhkd -c ~/.config/sxhkd/sxhkdrc &
# ~/.config/polybar/launch.sh "$HOST"
~/.config/dunst/launch.sh
feh --bg-fill ~/.config/wall.png &
udiskie -A -t &
xfce4-power-manager &
nohup nextcloud &

while true; do
    # killall dwmblocks
    dwmblocks || exit
done &

ps aux |grep -E "st - [h]eiko@localhost" > /dev/null
if [ $? -ne 0 ]; then
    nohup st -c "st - heiko@localhost" -T "st - heiko@localhost" &
fi
if [ "$HOST" = "manjaro" ]; then
    ps aux |grep -E "st - [h]eiko@ptlisvltnms027" > /dev/null
    if [ $? -ne 0 ]; then
        nohup st -c "st - heiko@ptlisvltnms027" -T "st - heiko@ptlisvltnms027" &
    fi
fi
ps aux | grep -E "[f]irefox" > /dev/null
if [ $? -ne 0 ]; then
    nohup firefox &
fi
# ps aux | grep -E "[s]ignal-desktop" > /dev/null
# if [ $? -ne 0 ]; then
#     nohup signal-desktop &
# fi
ps aux |grep -E "st - [h]eiko@ed" > /dev/null
if [ $? -ne 0 ]; then
    nohup st -c "st - heiko@ed" -T "st - heiko@ed" &
fi
