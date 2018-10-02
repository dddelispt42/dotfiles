#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")
PKGFILE="/tmp/all.pkgs"
INSTALLEDPKGFILE="/tmp/installed.pkgs"
TOBEINSTPKGFILE="/tmp/toBeInstalled.pkgs"

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
            sed -i '' -e 's/--height.*%\} //g' shell/key-bindings.bash
            sed -i '' -e 's/--height.*%\} //g' shell/key-bindings.zsh
            popd
        fi
    fi
}

function install_package {
    INSTALLCMD="echo "
    grep -E "^ID=(manjaro|arch)" /etc/os-release > /dev/null
    if [ $? -eq 0 ]; then
        pacsearch -n ^[a-z] | grep -v "^ " | sed -e 's/.*\/\(.*\) .*/\1/' > $PKGFILE
        pacman -Qqe > $INSTALLEDPKGFILE
        INSTALLCMD="sudo pacman -S "
    fi
    grep -E "^ID=(debian)" /etc/os-release > /dev/null
    if [ $? -eq 0 ]; then
        apt-cache pkgnames > $PKGFILE
        dpkg --get-selections | grep -E "\sinstall" | sed -e 's/\s.*//' > $INSTALLEDPKGFILE
        INSTALLCMD="sudo apt-get install "
    fi
    grep -v "^#" $1 > $TOBEINSTPKGFILE
    while read -r line; do
        pkgs=$(echo $line | tr " " "\n")
        for pkg in $pkgs
        do
            grep "^$pkg$" $PKGFILE > /dev/null
            if [ $? -eq 0 ]; then
                grep -E "^$pkg$" $INSTALLEDPKGFILE > /dev/null
                if [ $? -ne 0 ]; then
                    echo $INSTALLCMD $pkg
                fi
            else
                echo $pkg is not existing!
            fi
        done
    done < $TOBEINSTPKGFILE
}

function update_bootstrap {
    # call bootstap.sh in subdirs
    for app in `find . -maxdepth 1 -type d | grep -v "^\./\." | grep -v "^\.$"` ; do
        echo "Setting up (or updating) $app ..."
        pushd $app > /dev/null
        if [ -x ./$(basename $0) ]; then
            ./$(basename $0)
        fi
        popd > /dev/null
        echo "... done!"
    done
}

# TODO: more profiles <02-10-18, Heiko Riemer> #
install_package $BASEDIR/packages.txt
install_package $BASEDIR/packagesX.txt
install_powerline_fonts
fix_fzf_for_windows
update_bootstrap
