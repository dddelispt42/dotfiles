#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.zshrc ] ; then
    mv ~/.zshrc ~/.zshrc.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/zshrc ~/.zshrc
ln -sf ${BASEDIR}/oh-my-zsh ~/.oh-my-zsh

if [ -d ${BASEDIR}/oh-my-zsh ] ; then
    cd ${BASEDIR}/oh-my-zsh
    git pull
    cd -
else
    git clone https://github.com/robbyrussell/oh-my-zsh.git ${BASEDIR}/oh-my-zsh
fi
if [ ! -f ${BASEDIR}/zshrc ] ; then
    cp ${BASEDIR}/oh-my-zsh/templates/zshrc.zsh-template ${BASEDIR}/zshrc
fi
