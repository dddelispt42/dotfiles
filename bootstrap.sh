#!/bin/bash

<<<<<<< HEAD
doas pacman -S stow zsh git openssh starship trash-cli zoxide fzf neovim
[[ -n ${LANG+z} ]] || (doas nvim /etc/locale.gen; doas locale-gen)
mkdir -p "$HOME/dev/heiko"
cd "$HOME/dev/heiko" || exit
test -d dotfiles || git clone ssh://git@git/home/git/dotfiles.git
test -d bootstrap || git clone ssh://git@git/home/git/bootstrap.git
cd dotfiles || exit
./install.sh
=======
doas pacman -Syu
doas pacman -S stow zsh git openssh
mkdir -p "$HOME/.ssh"
chmod 600
test -s "$HOME/.ssh/id_rsa_low" || ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)-low" -f "$_"
test -s "$HOME/.ssh/id_rsa_high" || ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)-high" -f "$_"
echo "Add public key to authorized_keys for git server:"
cat "$HOME/.ssh/id_rsa_low.pub"
>>>>>>> 0221e97 (add a bootstrap.sh script)
