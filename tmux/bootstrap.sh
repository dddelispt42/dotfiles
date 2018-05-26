#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.tmux.conf ] ; then
    mv ~/.tmux.conf ~/.tmux.conf.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/tmux.conf ~/.tmux.conf

if [ -d ~/.config/tmuxinator ] ; then
    mv ~/.config/tmuxinator ~/.config/tmuxinator.dotfiles-$(date -I)
fi

if [ -d ~/.tmuxinator ] ; then
    mv ~/.tmuxinator ~/.tmuxinator.dotfiles-$(date -I)
fi

ln -sfn ${BASEDIR}/tmuxinator ~/.config/tmuxinator
ln -sfn ${BASEDIR}/tmuxinator ~/.tmuxinator
