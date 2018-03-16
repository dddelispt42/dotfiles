#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.agignore ] ; then
    mv ~/.agignore ~/.agignore.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/ignore ~/.agignore
