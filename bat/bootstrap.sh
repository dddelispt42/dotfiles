#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")
source ../dotfile_functions.sh

mkdir -p ${XDG_CONFIG_HOME}/bat
create_dotfile_link "${BASEDIR}/config" ${XDG_CONFIG_HOME}/bat/config
