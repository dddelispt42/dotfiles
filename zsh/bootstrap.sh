#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link "${BASEDIR}/zshrc" ~/.zshrc
create_dotfile_link "${BASEDIR}/p10k.zsh" ~/.p10k.zsh
# create_dotfile_link "${BASEDIR}/oh-my-zsh" ~/.oh-my-zsh
create_dotfile_link "${BASEDIR}/zplug" ~/.zplug

if [ -d "${BASEDIR}/zplug" ] ; then
    git -C "${BASEDIR}/zplug" pull
else
    git clone https://github.com/zplug/zplug "${BASEDIR}/zplug"
fi
# if [ -d "${BASEDIR}/oh-my-zsh" ] ; then
#     git -C "${BASEDIR}/oh-my-zsh" pull
# else
#     git clone https://github.com/robbyrussell/oh-my-zsh.git "${BASEDIR}/oh-my-zsh"
# fi
# if [ ! -f "${BASEDIR}/zshrc" ] ; then
#     cp "${BASEDIR}/oh-my-zsh/templates/zshrc.zsh-template" "${BASEDIR}/zshrc"
# fi
