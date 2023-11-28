#!/bin/bash
WID="$(hyprctl activewindow | grep "^Window " | sed "s/^Window \(.*\) ->.*/0x\1/")"
hyprctl setprop address:"$WID" "$1" "$2"

