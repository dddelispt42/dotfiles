#!/bin/bash
FILE="package.list"

echo $? > /dev/null
if [ $? -ne 0 ] ; then
    echo "Chocolatey not installed or not in PATH!!!"
    exit 1
fi

id | grep Administrators > /dev/null
if [ $? -ne 0 ] ; then
    echo "This needs to run in a admin shell!!!"
    exit 1
fi

while read package; do
    choco list --local-only | grep "$package" > /dev/null
    if [ $? -ne 0 ] ; then
        choco install $package -y
    else
        choco upgrade $package -y
    fi
done < "$FILE"
