#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")
source ../dotfile_functions.sh

if [ "$OS" == "Windows_NT" ]; then
    cp "${BASEDIR}/gitconfig" ~/.gitconfig
else
    create_dotfile_link "${BASEDIR}/gitconfig" ~/.gitconfig
fi
