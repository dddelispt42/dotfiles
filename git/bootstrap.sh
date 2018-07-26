#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.gitconfig ] ; then
    mv ~/.gitconfig ~/.gitconfig.dotfiles-$(date -I)
fi

# links do not work with GIT BASH for windows --> copy
# ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
cp ${BASEDIR}/gitconfig ~/.gitconfig
