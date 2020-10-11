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
[[ -f ~/.agent.sh ]] && trash ~/.agent.sh
[[ -d ~/.config/bat ]] && trash ~/.config/bat
[[ -L ~/.config/bspwm ]] && trash ~/.config/bspwm
[[ -L ~/.config/dunst ]] && trash ~/.config/dunst
[[ -L ~/.config/lf ]] && trash ~/.config/lf
[[ -L ~/.config/polybar ]] && trash ~/.config/polybar
[[ -L ~/.config/sxhkd ]] && trash ~/.config/sxhkd
[[ -L ~/.screenrc ]] && trash ~/.screenrc
[[ -L ~/.tmux.conf ]] && trash ~/.tmux.conf
[[ -L ~/.tmuxinator ]] && trash ~/.tmuxinator
[[ -L ~/.config/nvim ]] && trash ~/.config/nvim
[[ -L ~/.config/nvim/UltiSnips ]] && trash ~/.config/nvim/UltiSnips
[[ -L ~/.vimrc ]] && trash ~/.vimrc
[[ -L ~/.vim ]] && trash ~/.vim
[[ -L ~/.nvim ]] && trash ~/.nvim
[[ -L ~/.nvimrc ]] && trash ~/.nvimrc
[[ -L ~/.vim/UltiSnips ]] && trash ~/.vim/UltiSnips

# move things to XDG directories
function migrate_to_clean {
    [[ -f "$1" ]] && [[ ! -f "$2" ]] && mv "$1" "$2" && return
    [[ -d "$1" ]] && [[ ! -d "$2" ]] && mv "$1" "$2"
}
migrate_to_clean ~/.cmus "$XDG_CONFIG_HOME"/cmus
migrate_to_clean ~/.cargo "$XDG_CONFIG_HOME"/cargo
migrate_to_clean ~/.cht.sh "$XDG_CONFIG_HOME"/cht.sh
migrate_to_clean ~/.thumbnails "$XDG_CONFIG_HOME"/thumbnails
migrate_to_clean ~/.gimp-2.0 "$XDG_CONFIG_HOME"/gimp-2.0
migrate_to_clean ~/.gimp-2.2 "$XDG_CONFIG_HOME"/gimp-2.2
migrate_to_clean ~/.gimp-2.4 "$XDG_CONFIG_HOME"/gimp-2.4
migrate_to_clean ~/.gimp-2.6 "$XDG_CONFIG_HOME"/gimp-2.6
migrate_to_clean ~/.gimp-2.8 "$XDG_CONFIG_HOME"/gimp-2.8
migrate_to_clean ~/.gimp-2.10 "$XDG_CONFIG_HOME"/gimp-2.10
migrate_to_clean ~/.mutt "$XDG_CONFIG_HOME"/mutt
migrate_to_clean ~/.newsbeuter "$XDG_CONFIG_HOME"/newsbeuter
migrate_to_clean ~/.mpv "$XDG_CONFIG_HOME"/mpv
migrate_to_clean ~/.mpdconf "$XDG_CONFIG_HOME"/mpdconf
migrate_to_clean ~/vimfiles "$XDG_CACHE_HOME"/nvim
migrate_to_clean ~/.pylintrc "$XDG_CACHE_HOME"/pylintrc
migrate_to_clean ~/.pylint.d "$XDG_DATA_HOME"/pylint
migrate_to_clean ~/.htoprc "$XDG_CONFIG_HOME"/htoprc
migrate_to_clean ~/.httpie "$XDG_CONFIG_HOME"/httpie
migrate_to_clean ~/.inkscape "$XDG_CONFIG_HOME"/inkscape
migrate_to_clean ~/.i3 "$XDG_CONFIG_HOME"/i3
migrate_to_clean ~/.i3status.conf "$XDG_CONFIG_HOME"/i3status.conf
migrate_to_clean ~/.lftp.conf "$XDG_CONFIG_HOME"/lftp.conf
migrate_to_clean ~/.mc "$XDG_CONFIG_HOME"/mc
migrate_to_clean ~/.mypoint "$XDG_CONFIG_HOME"/mypoint
migrate_to_clean ~/.pandoc "$XDG_CONFIG_HOME"/pandoc
migrate_to_clean ~/.Skype "$XDG_CONFIG_HOME"/Skype

# call stow individually
stow -vS -t ~/ bat
stow -vS -t ~/ bspwm
stow -vS -t ~/ dunst
stow -vS -t ~/ git
stow -vS -t ~/ lf
stow -vS -t ~/ polybar
stow -vS -t ~/ sxhkd
stow -vS -t ~/ tmux
stow -vS -t ~/ nvim
stow -vS -t ~/ X11
# TODO: shell vim zsh
mkdir -p "$XDG_CACHE_HOME"/nvim/{undo,backup,swap,sessions}
if command -v nvim > /dev/null; then
    nvim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
else
    vim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
fi

# finally cleanup this script
