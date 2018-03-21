#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

# call bootstap.sh in subdirs
for app in `find . -maxdepth 1 -type d | grep -v "^\./\." | grep -v "^\.$"` ; do
    echo "Setting up (or updating) $app ..."
    $app/$(basename $0)
    echo "... done!"
done
