#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

# setup nvim
mkdir -p ${XDG_CONFIG_HOME}/nvim/
create_dotfile_link ${BASEDIR}/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
create_dotfile_link ${BASEDIR}/UltiSnips ${XDG_CONFIG_HOME}/nvim/UltiSnips

# setup vim
mkdir -p ~/.vim
create_dotfile_link "${BASEDIR}"/init.vim ~/.vimrc
create_dotfile_link "${BASEDIR}"/init.vim ~/.vim/vimrc
create_dotfile_link "${BASEDIR}"/UltiSnips ~/.vim/UltiSnips

# copy to windows versions
if [ "$OSTYPE" = "cygwin" ]; then
    mkdir -p $XDG_CONFIG_HOME/nvim
    cp ${BASEDIR}/init.vim $LOCALAPPDATA/nvim/
    cp -R ${BASEDIR}/UltiSnips $LOCALAPPDATA/nvim/UltiSnips
    nvim-qt +PlugInstall +PlugUpdate +PlugClean +qall
elif [ "$OS" = "Windows_NT" ]; then
    cp ${BASEDIR}/init.vim $LOCALAPPDATA/nvim/
    cp -R ${BASEDIR}/UltiSnips $LOCALAPPDATA/nvim/UltiSnips
    nvim-qt +PlugInstall +PlugUpdate +PlugClean +qall
else
    nvim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
fi

# update VIM/NeoVIM
if vim --version | grep Compiled > /dev/null; then
    vim +PlugInstall +PlugUpdate +PlugClean +qall
fi

