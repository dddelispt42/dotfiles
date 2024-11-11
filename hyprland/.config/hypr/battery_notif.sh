#!/bin/bash

while true; do
    BATTERY_PATH=$(upower -e | grep battery)
    LINE_POWER_PATH=$(upower -e | grep line_power)
    BATTERY_PERCENTAGE=$(upower -i $BATTERY_PATH | grep 'percentage:' | awk '{ print $2 }' | sed 's/%//')
    CABLE_PLUGGED=$(upower -i $LINE_POWER_PATH | grep -A2 'line-power' | grep online | awk '{ print $2 }')

    if [[ $CABLE_PLUGGED == 'yes' ]]; then

        if [[ $BATTERY_PERCENTAGE -gt 90 ]]; then
            notify-send --urgency=critical "Battery optimization" "Battery reached 90%, unplug the power cable to optimize battery life."
        fi

    else

        if [[ $BATTERY_PERCENTAGE -lt 20 ]]; then
            notify-send --urgency=critical "Battery optimization" "Battery is below 20%, plug in the power cable to optimize battery life."
        fi

    fi
    sleep 300
done
