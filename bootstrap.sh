#!/bin/bash

doas pacman -Syu
doas pacman -S stow zsh git openssh
mkdir -p "$HOME/.ssh"
chmod 600
test -s "$HOME/.ssh/id_rsa_low" || ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)-low" -f "$_"
test -s "$HOME/.ssh/id_rsa_high" || ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)-high" -f "$_"
echo "Add public key to authorized_keys for git server:"
cat "$HOME/.ssh/id_rsa_low.pub"
