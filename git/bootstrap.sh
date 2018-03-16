#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.gitconfig ] ; then
    mv ~/.gitconfig ~/.gitconfig.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
