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
${XDG_CONFIG_HOME:-$HOME/.config}/dunst/launch.sh &
feh --bg-fill ${XDG_CONFIG_HOME:-$HOME/.config}/wall.png &
udiskie -A -t &
nohup xfce4-power-manager &
nohup nextcloud &
trayer --edge top --align center --expand false --width 5 --distance 20 &
nohup clipmenud &

while true; do
    # killall dwmblocks
    dwmblocks || exit
done &

# while true; do
#     xrandr.sh
#     sleep 15
# done &

ps aux |grep -E "st - [h]eiko@localhost" > /dev/null
if [ $? -ne 0 ]; then
    nohup st -c "st - heiko@localhost" -T "st - heiko@localhost" &
fi
if [ "$HOST" = "work" ]; then
    ps aux |grep -E "st - [h]eiko@lab" > /dev/null
    if [ $? -ne 0 ]; then
        nohup st -c "st - heiko@lab" -T "st - heiko@lab" &
    fi
fi
ps aux | grep -E "[f]irefox" > /dev/null
if [ $? -ne 0 ]; then
    nohup firefox &
fi
ps aux | grep -E "[s]ignal-desktop" > /dev/null
if [ $? -ne 0 ]; then
    nohup signal-desktop &
fi
ps aux |grep -E "st - [h]eiko@ed" > /dev/null
if [ $? -ne 0 ]; then
    nohup st -c "st - heiko@ed" -T "st - heiko@ed" &
fi
