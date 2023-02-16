#!/bin/sh
CACHEFILE="$HOME/.cache/wttr.$USER"
find "$CACHEFILE" -mmin -120 >/dev/null || curl -s 'wttr.in/Lisbon?format=%c+%t+%h+%p+%o+%w' | sed 's/  / /g' >"$CACHEFILE"
cat "$CACHEFILE"
