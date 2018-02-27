#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -d ~/.vim ] ; then
    mv ~/.vim ~/.vim.dotfiles-$(date -I)
fi
if [ -f ~/.vimrc ] ; then
    mv ~/.vimrc ~/.vimrc.dotfiles-$(date -I)
fi

ln -sf $BASEDIR ~/.vim
ln -sf ${BASEDIR}/vimrc ~/.vimrc
ln -sf ~/.vim ~/.nvim
ln -sf ~/.vimrc ~/.nvimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# TODO: (heiko) - check if plantuml.jar is in bin and create plantuml.sh
