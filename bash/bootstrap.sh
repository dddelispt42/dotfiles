#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link ${BASEDIR}/profile ~/.profile
create_dotfile_link ${BASEDIR}/bashrc ~/.bashrc
create_dotfile_link ${BASEDIR}/bash_profile ~/.bash_profile
create_dotfile_link ${BASEDIR}/bash_logout ~/.bash_logout

if [ -d ${BASEDIR}/liquidprompt ] ; then
    cd ${BASEDIR}/liquidprompt
    git pull
else
    git clone https://github.com/nojhan/liquidprompt.git
fi

if [ ! -f ~/.config/liquidpromptrc ] ; then
    cp ${BASEDIR}/liquidprompt/liquidpromptrc-dist ~/.config/liquidpromptrc
fi

