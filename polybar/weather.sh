#!/bin/sh
CACHEFILE="$HOME/.cache/wttr.$USER"
# curl 'wttr.in/Lisbon?format=%l+%c+%t+%h+%p+%o+%w+%m'
curl -s 'wttr.in/Lisbon?format=%c+%t+%h+%p+%o+%w' | tee "$CACHEFILE" || cat "$CACHEFILE" || echo "???"
