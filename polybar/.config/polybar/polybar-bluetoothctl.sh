#!/bin/bash

bluetooth_print() {
	export device_list=""
	for line in $(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2); do
		device_info=$(bluetoothctl info "$line")
		if echo "$device_info" | grep -q "Connected: yes"; then
			device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
			if [ "$device_list" == "" ]; then
				device_list="${device_alias}"
			else
				device_list="${device_list}, ${device_alias}"
			fi
		fi
	done
	if [ "$device_list" == "" ]; then
		# echo "%{B#f00}%{F#fff}NO DEVICE%{B- F-}"
		echo "-"
	else
		# echo "%{B#0f0}%{F#000}${device_list}%{B- F-}"
		echo "%{B#98971a}%{F#ebdbb2}${device_list}%{B- F-}"
	fi
}

bluetooth_toggle() {
	if bluetoothctl show | grep -q "Powered: no"; then
		bluetoothctl power on >>/dev/null
		sleep 1
	fi
	device="$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 3- | dmenu -l 10 -w 300)"
	if [ "$device" != "" ]; then
		device_mac="$(bluetoothctl devices Paired | grep "$device" | cut -d ' ' -f 2)"
		if bluetoothctl info "$device_mac" | grep -q "Connected: yes"; then
			bluetoothctl disconnect "$device_mac" >/dev/null
		else
			bluetoothctl connect "$device_mac" >/dev/null
		fi
		sleep 1
	fi
}

if [ "$(systemctl is-active "bluetooth.service")" != "active" ] || bluetoothctl show | grep -q "Powered: no"; then
	echo "%{B#f00}%{F#000} bluetooth OFF %{B- F-}"
	exit
fi

case "$1" in
--toggle)
	bluetooth_toggle
	bluetooth_print
	;;
*)
	bluetooth_print
	;;
esac
