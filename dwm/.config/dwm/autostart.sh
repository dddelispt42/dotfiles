#!/bin/bash
#this file is called by .xinitrc to start some nice apps for dwm
HOST=$(hostname)
TERMI="${TERMINAL:-alacritty}"

if [ "$HOST" == "work" ]; then
    # MONITOR=$(xrandr --listmonitors | grep -v "Monitors:" | sed 's/.*\s//;1q')
    # xrandr --output $MONITOR --mode 1920x1080 --rate 60
    VBoxClient --vmsvga
    VBoxClient --clipboard
    VBoxClient --draganddrop
    VBoxClient --seamless
    # VBoxClient --display
    VBoxClient --checkhostversion
fi

xrdb -merge "${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources"
xrdb "${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources"
# sxhkd -c ${XDG_CONFIG_HOME:-$HOME/.config}/sxhkd/sxhkdrc &
"${XDG_CONFIG_HOME:-$HOME/.config}/polybar/launch.sh" "$HOST"
"${XDG_CONFIG_HOME:-$HOME/.config}/dunst/launch.sh" &
# feh --bg-fill "${XDG_CONFIG_HOME:-$HOME/.config}/wp.jpg" &
udiskie -A -t &
nohup xfce4-power-manager &
nohup nextcloud &
# trayer --edge top --align center --expand false --width 5 --distance 20 &
nohup clipmenud &
nohup brave &
nohup qutebrowser &
nohup "$TERMI" --class "$TERMI - heiko@localhost" --title "$TERMI - heiko@localhost" &
nohup "$TERMI" --class "$TERMI - heiko@ed" --title "$TERMI - heiko@ed" &
nohup "$TERMI" --class "$TERMI - heiko@ed2" --title "$TERMI - heiko@ed2" &
nohup "$TERMI" --class "$TERMI - heiko@backup" --title "$TERMI - heiko@backup" &
nohup anki &
nohup tbb &
nohup signal-desktop &
