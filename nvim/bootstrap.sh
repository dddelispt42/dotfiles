#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

mkdir -p ${XDG_CONFIG_HOME}/nvim/
create_dotfile_link ${BASEDIR}/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
create_dotfile_link ${BASEDIR}/UltiSnips ${XDG_CONFIG_HOME}/nvim/UltiSnips
create_dotfile_link ${BASEDIR}/local_init.vim ${XDG_CONFIG_HOME}/nvim/local_init.vim
create_dotfile_link ${BASEDIR}/local_bundles.vim ${XDG_CONFIG_HOME}/nvim/local_bundles.vim

# copy to windows versions
if [ "$OSTYPE" = "cygwin" ]; then
    mkdir -p $XDG_CONFIG_HOME/nvim
    echo "Detected Windows --> copy NVIM config to %HOME%\\AppData\\Local\\nvim"
    cp ${BASEDIR}/init.vim ${BASEDIR}/local_init.vim ${BASEDIR}/local_bundles.vim $LOCALAPPDATA/nvim/
    # substitute paths to windows format and location
    sed -i "s/let g:session_directory = \"~\/\.config\/nvim\/session\"/let g:session_directory = \'c:\\\Users\\\\$USER\\\AppData\\\Local\\\nvim\\\session\'/" \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
    sed -i "s/~\/\.config\/nvim\/autoload\//c:\\\Users\\\\$USER\\\AppData\\\Local\\\nvim\\\autostart\\\/" \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
    sed -i "s/~\/\.config\/nvim\//c:\\\Users\\\\$USER\\\AppData\\\Local\\\nvim\\\/" \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
    # set command prompt as default shell
    sed -i 's/set shell=\/.*bin\/sh/set shell=cmd/' \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
    nvim-qt +PlugInstall +PlugUpdate +PlugClean +qall
elif [ "$OS" = "Windows_NT" ]; then
    # sed -i -e "s/'--ansi', //g;s/--ansi //" plugged/fzf.vim/autoload/fzf/vim.vim
    # sed -i -e "s/'--header-lines', .*), //g;s/--header-lines=1 //;s/--header-lines[ =]1//" plugged/fzf.vim/autoload/fzf/vim.vim
    nvim-qt +PlugInstall +PlugUpdate +PlugClean +qall
else
    nvim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
fi

