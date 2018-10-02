#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link ${BASEDIR}/tmux.conf ~/.tmux.conf
create_dotfile_link ${BASEDIR}/tmuxinator ~/.config/tmuxinator
create_dotfile_link ${BASEDIR}/tmuxinator ~/.tmuxinator
