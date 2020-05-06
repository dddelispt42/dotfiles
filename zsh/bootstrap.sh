#!/bin/bash
BASEDIR="$(dirname "$(realpath "$0")")"
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
