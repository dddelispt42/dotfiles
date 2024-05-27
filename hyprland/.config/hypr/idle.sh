#!/bin/bash
# swayidle -w \
# 	timeout 600 'swaylock -f -c 000000' \
# 	timeout 3600 'loginctl suspend' \
# 	before-sleep 'swaylock -f -c 000000'
swayidle -w \
	timeout 1800 'waylock' \
	timeout 3600 'loginctl suspend' \
	before-sleep 'waylock'
