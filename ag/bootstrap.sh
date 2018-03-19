#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.ignore ] ; then
    mv ~/.ignore ~/.ignore.dotfiles-$(date -I)
fi
if [ -f ~/.rgignore ] ; then
    mv ~/.rgignore ~/.rgignore.dotfiles-$(date -I)
fi
if [ -f ~/.agignore ] ; then
    mv ~/.agignore ~/.agignore.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/ignore ~/.ignore
ln -sf ${BASEDIR}/ignore ~/.agignore
ln -sf ${BASEDIR}/ignore ~/.rgignore
