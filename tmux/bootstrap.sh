#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.tmux.conf ] ; then
    mv ~/.tmux.conf ~/.tmux.conf.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/tmux.conf ~/.tmux.conf
