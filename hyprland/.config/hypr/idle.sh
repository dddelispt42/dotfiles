#!/bin/bash
swayidle -w \
	timeout 300 'swaylock -f -c 000000' \
	before-sleep 'swaylock -f -c 000000'
