#!/usr/bin/env bash

# Terminate already running bar instances
killall -q dunst

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
echo "---" | tee -a /tmp/dunst.log /tmp/dunst.log
dunst >>/tmp/dunst.log 2>&1 &

echo "Dunst launched..."
