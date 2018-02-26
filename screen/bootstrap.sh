#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.screenrc ] ; then
    mv ~/.screenrc ~/.screenrc.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/screenrc ~/.screenrc
