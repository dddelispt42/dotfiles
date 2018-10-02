#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

function install_powerline_fonts {
    git clone https://github.com/powerline/fonts
    pushd fonts
    ./install.sh
    if [ "$HOME" = "/cygdrive/c/Data/$USER/" ] ; then
        read -p "Reinstall Windows Powerline Fonts? [y/N]" yn
        if [ "$yn" = "y" ]; then
            Powershell -File install.ps1
        fi
    fi
    popd
    rm -rf ./fonts
}

function fix_fzf_for_windows {
    if [ "$HOME" = "/cygdrive/c/Data/$USER/" ] ; then
        if [ -d $HOME/.fzf ]; then
            pushd $HOME/.fzf
            git checkout -- shell/key-bindings.bash shell/key-bindings.zsh
            git pull
            sed -ie 's/--height.*%\} //g' shell/key-bindings.bash
            sed -ie 's/--height.*%\} //g' shell/key-bindings.zsh
            rm -f shell/key-bindings.bashe shell/key-bindings.zshe
            popd
        fi
    fi
}

# call bootstap.sh in subdirs
for app in `find . -maxdepth 1 -type d | grep -v "^\./\." | grep -v "^\.$"` ; do
    echo "Setting up (or updating) $app ..."
    pushd $app > /dev/null
    ./$(basename $0)
    popd > /dev/null
    echo "... done!"
done

install_powerline_fonts
fix_fzf_for_windows
