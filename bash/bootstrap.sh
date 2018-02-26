#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -f ~/.profile ] ; then
    mv ~/.profile ~/.profile.dotfiles-$(date -I)
fi
if [ -f ~/.bashrc ] ; then
    mv ~/.bashrc ~/.bashrc.dotfiles-$(date -I)
fi
if [ -f ~/.bash_profile ] ; then
    mv ~/.bash_profile ~/.bash_profile.dotfiles-$(date -I)
fi
if [ -f ~/.bash_logout ] ; then
    mv ~/.bash_logout ~/.bash_logout.dotfiles-$(date -I)
fi

ln -sf ${BASEDIR}/profile ~/.profile
ln -sf ${BASEDIR}/bashrc ~/.bashrc
ln -sf ${BASEDIR}/bash_profile ~/.bash_profile
ln -sf ${BASEDIR}/bash_logout ~/.bash_logout

if [ -d ${BASEDIR}/liquidprompt ] ; then
    cd ${BASEDIR}/liquidprompt
    git pull
else
    git clone https://github.com/nojhan/liquidprompt.git
fi

if [ ! -f ~/.config/liquidpromptrc ] ; then
    cp ${BASEDIR}/liquidprompt/liquidpromptrc-dist ~/.config/liquidpromptrc
fi

