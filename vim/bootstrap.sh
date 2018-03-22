#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -d ~/.vim ] ; then
    mv ~/.vim ~/.vim.dotfiles-$(date -I)
fi
if [ -f ~/.vimrc ] ; then
    mv ~/.vimrc ~/.vimrc.dotfiles-$(date -I)
fi

ln -sfn $BASEDIR ~/.vim
ln -sf ${BASEDIR}/vimrc ~/.vimrc

if [ -d ~/.vim/bundle/Vundle.vim ] ; then
    cd ~/.vim/bundle/Vundle.vim
    git pull
    cd -
else
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# TODO: (heiko) - check if plantuml.jar is in bin and create plantuml.sh
