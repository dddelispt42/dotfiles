#!/bin/bash
intern=eDP1
extern=HDMI1
extern2=HDMI2

if xrandr | grep "$extern connected"; then
    xrandr --output "$intern" --off --output "$extern" --primary --auto
elif xrandr | grep "$extern2 connected"; then
    xrandr --output "$intern" --off --output "$extern2" --primary --auto
else
    xrandr --output "$extern" --off --output "$extern2" --off --output "$intern" --primary --auto
fi
