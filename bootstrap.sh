#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

# call bootstap.sh in subdirs
for app in `find . -maxdepth 1 -type d | grep -v "^\./\." | grep -v "^\.$"` ; do
    echo "Setting up (or updating) $app ..."
    pushd $app > /dev/null
    ./$(basename $0)
    popd > /dev/null
    echo "... done!"
done
