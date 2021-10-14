#!/bin/bash

doas pacman -Syu
doas pacman -S stow zsh git openssh starship trash-cli zoxide fzf neovim
[[ -n ${LANG+z} ]] || (doas nvim /etc/locale.gen; doas locale-gen)
mkdir -p "$HOME/dev/heiko"
cd "$HOME/dev/heiko" || exit
test -d dotfiles || git clone ssh://git@git/home/git/dotfiles.git
test -d bootstrap || git clone ssh://git@git/home/git/bootstrap.git
cd dotfiles || exit
./install.sh
