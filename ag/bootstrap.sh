#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link "${BASEDIR}/ignore" ~/.ignore
create_dotfile_link "${BASEDIR}/ignore" ~/.agignore
create_dotfile_link "${BASEDIR}/ignore" ~/.rgignore
