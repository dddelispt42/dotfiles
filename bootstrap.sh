#!/bin/bash
# BASEDIR=$(pwd)/$(dirname "$0")
# PKGFILE="/tmp/all.pkgs"
# INSTALLEDPKGFILE="/tmp/installed.pkgs"
# TOBEINSTPKGFILE="/tmp/toBeInstalled.pkgs"

# function install_powerline_fonts {
#     git clone https://github.com/powerline/fonts
#     pushd fonts || return
#     ./install.sh
#     if [ "$HOME" = "/cygdrive/c/Data/$USER/" ] ; then
#         read -p "Reinstall Windows Powerline Fonts? [y/N]" yn
#         if [ "$yn" = "y" ]; then
#             Powershell -File install.ps1
#         fi
#     fi
#     popd || return
#     rm -rf ./fonts
# }

# function fix_fzf_for_windows {
#     if [ "$HOME" = "/cygdrive/c/Data/$USER/" ] ; then
#         if [ -d "$HOME/.fzf" ]; then
#             pushd "$HOME/.fzf" || return
#             git checkout -- shell/key-bindings.bash shell/key-bindings.zsh
#             git pull
#             sed -i -e 's/--height.*%\} //g' shell/key-bindings.bash
#             sed -i -e 's/--height.*%\} //g' shell/key-bindings.zsh
#             popd || return
#         fi
#     fi
# }

# function install_package {
#     INSTALLCMD="echo "
#     touch $PKGFILE
#     touch $INSTALLEDPKGFILE
#     grep -E "^ID=(manjaro|arch)" /etc/os-release > /dev/null
#     if [ $? -eq 0 ]; then
#         pacsearch -n ^[a-z] | grep -v "^ " | sed -e 's/.*\/\(.*\) .*/\1/' > $PKGFILE
#         pacman -Qqe > $INSTALLEDPKGFILE
#         INSTALLCMD="sudo pacman -S "
#     fi
#     grep -E "^ID=(debian)" /etc/os-release > /dev/null
#     if [ $? -eq 0 ]; then
#         apt-cache pkgnames > $PKGFILE
#         dpkg --get-selections | grep -E '\sinstall' | sed -e 's/\s.*//' > $INSTALLEDPKGFILE
#         INSTALLCMD="sudo apt-get install "
#     fi
#     grep -v "^#" "$1" > $TOBEINSTPKGFILE
#     while read -r line; do
#         pkgs=$(echo "$line" | tr " " "\n")
#         for pkg in $pkgs
#         do
#             grep "^$pkg$" $PKGFILE > /dev/null
#             if [ $? -eq 0 ]; then
#                 grep -E "^$pkg$" $INSTALLEDPKGFILE > /dev/null
#                 if [ $? -ne 0 ]; then
#                     echo "$INSTALLCMD $pkg"
#                 fi
#             else
#                 echo "$pkg is not existing!"
#             fi
#         done
#     done < $TOBEINSTPKGFILE
# }

function update_bootstrap {
    # call bootstap.sh in subdirs
    for app in $(find . -maxdepth 1 -type d | grep -v "^\./\." | grep -v "^\.$") ; do
        echo "Setting up (or updating) $app ..."
        pushd "$app" > /dev/null || return
        if [ -x ./"$(basename "$0")" ]; then
            ./"$(basename "$0")"
        fi
        popd > /dev/null || return
        echo "... done!"
    done
}

# TODO: more profiles <02-10-18, Heiko Riemer> #
# install_package $BASEDIR/packages.txt
# install_package $BASEDIR/packagesX.txt
# install_powerline_fonts
# fix_fzf_for_windows
update_bootstrap


# clean up legacy manual links - pre stow
[[ -L ~/.ignore ]] && trash ~/.ignore
[[ -L ~/.agignore ]] && trash ~/.agignore
[[ -L ~/.rgignore ]] && trash ~/.rgignore
[[ -L ~/.gitignore ]] && trash ~/.gitignore
[[ -L ~/.gitconfig ]] && trash ~/.gitconfig
[[ -L ~/.profile ]] && trash ~/.profile
[[ -L ~/.bashrc ]] && trash ~/.bashrc
[[ -L ~/.bash_profile ]] && trash ~/.bash_profile
[[ -L ~/.bash_logout ]] && trash ~/.bash_logout
[[ -f ~/.config/liquidpromptrc ]] && trash ~/.config/liquidpromptrc
[[ -L ~/.agent.sh ]] && trash ~/.agent.sh
[[ -d ~/.config/bat ]] && trash ~/.config/bat
[[ -L ~/.config/bspwm ]] && trash ~/.config/bspwm
[[ -L ~/.config/dunst ]] && trash ~/.config/dunst
[[ -L ~/.config/lf ]] && trash ~/.config/lf
[[ -L ~/.config/polybar ]] && trash ~/.config/polybar
[[ -L ~/.config/sxhkd ]] && trash ~/.config/sxhkd
[[ -L ~/.screenrc ]] && trash ~/.screenrc
[[ -L ~/.tmux.conf ]] && trash ~/.tmux.conf
[[ -L ~/.tmuxinator ]] && trash ~/.tmuxinator

# move things to XDG directories
function migrate_to_clean {
    [[ -f "$1" ]] && [[ ! -f "$2" ]] && mv "$1" "$2" && return
    [[ -d "$1" ]] && [[ ! -d "$2" ]] && mv "$1" "$2"
}
migrate_to_clean ~/.cmus ~/.config/cmus
migrate_to_clean ~/.cargo ~/.config/cargo
migrate_to_clean ~/.cht.sh ~/.config/cht.sh
migrate_to_clean ~/.thumbnails ~/.config/thumbnails
migrate_to_clean ~/.gimp-2.0 ~/.config/gimp-2.0
migrate_to_clean ~/.gimp-2.2 ~/.config/gimp-2.2
migrate_to_clean ~/.gimp-2.4 ~/.config/gimp-2.4
migrate_to_clean ~/.gimp-2.6 ~/.config/gimp-2.6
migrate_to_clean ~/.gimp-2.8 ~/.config/gimp-2.8
migrate_to_clean ~/.gimp-2.10 ~/.config/gimp-2.10

# call stow individually
stow -vS -t ~/ bat
stow -vS -t ~/ bspwm
stow -vS -t ~/ dunst
stow -vS -t ~/ git
stow -vS -t ~/ lf
stow -vS -t ~/ polybar
stow -vS -t ~/ sxhkd
stow -vS -t ~/ tmux
# TODO: nvim shell vim X zsh

# finally cleanup this script
