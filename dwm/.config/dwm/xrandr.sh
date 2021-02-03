#!/bin/bash
intern=eDP1
extern1=DP1
extern2=DP2
extern3=HDMI1
extern4=HDMI2

if xrandr | grep "^$extern1 connected" > /dev/null; then
    xrandr --output "$extern1" --primary --mode 3840x2160 --rate 30.00 --output "$intern" --off
elif xrandr | grep "^$extern2 connected" > /dev/null; then
    xrandr --output "$extern2" --primary --mode 3840x2160 --rate 30.00 --output "$intern" --off
elif xrandr | grep "^$extern3 connected" > /dev/null; then
    xrandr --output "$extern4" --primary --auto --output "$intern" --off
elif xrandr | grep "^$extern4 connected" > /dev/null; then
    xrandr --output "$extern3" --primary --auto --output "$intern" --off
else
    xrandr --output "$intern" --primary --auto
fi

# update dwmblocks
kill -44 "$(pidof dwmblocks)"
