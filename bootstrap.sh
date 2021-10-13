#!/bin/bash

doas pacman -S stow zsh git openssh starship trash-cli zoxide fzf neovim
[[ ! -z ${LANG+z} ]] || (doas nvim /etc/locale.gen; doas locale-gen)
cd "$HOME/dev/heiko"
git clone ssh://git@git/home/git/dotfiles.git
cd dotfiles
./install.sh
