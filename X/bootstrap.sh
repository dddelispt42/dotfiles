#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")
source ../dotfile_functions.sh

create_dotfile_link "${BASEDIR}/Xresources" ~/.Xresources
create_dotfile_link "${BASEDIR}/xinitrc" ~/.xinitrc
