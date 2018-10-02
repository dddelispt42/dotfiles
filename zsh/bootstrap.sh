#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link ${BASEDIR}/zshrc ~/.zshrc
create_dotfile_link ${BASEDIR}/oh-my-zsh ~/.oh-my-zsh

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
