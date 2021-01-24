#!/bin/bash
intern=eDP1
extern=HDMI1
extern2=DP1
extern3=HDMI2

if xrandr | grep "^$extern connected" > /dev/null; then
    xrandr --output "$extern" --primary --auto --output "$intern" --off
elif xrandr | grep "^$extern2 connected" > /dev/null; then
    xrandr --output "$extern2" --primary --auto --output "$intern" --off
elif xrandr | grep "^$extern3 connected" > /dev/null; then
    xrandr --output "$extern3" --primary --auto --output "$intern" --off
else
    xrandr --output "$extern" --off --output "$extern2" --off --output "$extern3" --off --output "$intern" --primary --auto
fi

# update dwmblocks
kill -44 "$(pidof dwmblocks)"
