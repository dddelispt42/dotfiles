#!/bin/bash
BASEDIR=$(dirname "$(realpath "$0")")
source ../dotfile_functions.sh

create_dotfile_link "$BASEDIR" ~/.vim
create_dotfile_link "${BASEDIR}"/vimrc ~/.vimrc
create_dotfile_link "${BASEDIR}"/../nvim/local_init.vim ~/.vimrc.local
create_dotfile_link "${BASEDIR}"/../nvim/local_bundles.vim ~/.vimrc.local.bundles

if [ "$OS" = "Windows_NT" ]; then
    # sed -i -e "s/'--ansi', //g;s/--ansi //" plugged/fzf.vim/autoload/fzf/vim.vim
    # sed -i -e "s/'--header-lines', .*), //g;s/--header-lines=1 //;s/--header-lines[ =]1//" plugged/fzf.vim/autoload/fzf/vim.vim
    vim +PlugInstall +PlugUpdate +PlugClean +qall
fi

# update VIM/NeoVIM
if vim --version | grep Compiled > /dev/null; then
    vim +PlugInstall +PlugUpdate +PlugClean +qall
fi

