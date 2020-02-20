#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")
source ../dotfile_functions.sh

create_dotfile_link "${BASEDIR}" ~/.config/dunst
