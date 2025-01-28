#!/bin/bash

BAT_HIGH=90
BAT_LOW=20
DISPLAY=:0

while true; do
    BATTERY_PATH=$(upower -e | grep battery | head -1)
    LINE_POWER_PATH=$(upower -e | grep line_power_AC | head -1)
    BATTERY_PERCENTAGE=$(upower -i "$BATTERY_PATH" | grep 'percentage:' | awk '{ print $2 }' | sed 's/%//')
    CABLE_PLUGGED=$(upower -i "$LINE_POWER_PATH" | grep -A2 'line-power' | grep online | awk '{ print $2 }')

    if [[ $CABLE_PLUGGED == 'yes' ]]; then

        if [[ $BATTERY_PERCENTAGE -gt $BAT_HIGH ]]; then
            notify-send --urgency=critical "Battery optimization" "Battery reached ${BAT_HIGH}%, unplug the power cable to optimize battery life."
            echo "Battery full!"
        fi

    else

        if [[ $BATTERY_PERCENTAGE -lt $BAT_LOW ]]; then
            notify-send --urgency=critical "Battery optimization" "Battery is below ${BAT_LOW}%, plug in the power cable to optimize battery life."
            echo "Battery almost empty!"
        fi

    fi
    sleep 300
done
