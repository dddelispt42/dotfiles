#!/bin/bash
# TODO make this work also for manjaro and debian

user=$USER

function run_as_root {
	pacman -Syyu --noconfirm
	pacman -S artix-archlinux-support --noconfirm

	if ! grep -E "^\[extra\]$" /etc/pacman.conf >/dev/null; then
		cat <<EOF >>/etc/pacman.conf
[extra]
Include = /etc/pacman.d/mirrorlist-arch

EOF
	fi

	pacman-key --populate archlinux
	pacman -Syyu --noconfirm
	pacman -S 7zip bat btrfs-progs bzip2 docker docker-compose docker-openrc eza fail2ban fail2ban-openrc fd fzf git git htop lnav neovim opendoas openntpd openssh restic ripgrep rsync sheldon snapper starship stow tailscale tmux tmuxp trash-cli wireguard-tools zoxide zsh

	[[ -n ${LANG+z} ]] || (
		nvim /etc/locale.gen
		locale-gen
	)

	rc-update add sshd
	rc-service sshd start
	rc-update add ntpd
	rc-service ntpd start
	rc-update add fail2ban
	rc-service fail2ban start
	rc-update add docker
	rc-service docker start

	usermod -aG docker "$user"

	read -r -p "Last byte of the IP address - 192.168.1." ip
	interface=$(connmanctl services | grep ethernet | sed 's/.*\s\(\w*\)$/\1/')
	connmanctl config "$interface" --nameservers 192.168.1.11 192.168.1.1
	connmanctl config "$interface" --autoconnect yes
	connmanctl config "$interface" --ipv4 manual "192.168.1.$ip" 255.255.255.0 192.168.1.254
}
sudo bash -c "$(declare -f run_as_root); run_as_root"
newgrp docker

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
test -d "${HOME}/opt" || mkdir -p "$_"
mkdir -p "$HOME/dev/heiko"
cd "$HOME/dev/heiko" || exit
test -s "$HOME/.ssh/id_ed25519" || ssh-keygen -t ed25519 -C "$(whoami)@$(cat /etc/hostname)-$(date -I)" -a 100
test -s "$HOME/.ssh/id_ed25519_sec" || ssh-keygen -t ed25519 -C "$(whoami)@$(cat /etc/hostname)-$(date -I)-sec" -f "$HOME/.ssh/id_ed25519_sec" -a 100
echo "Add public key to authorized_keys for git server:"
cat "$HOME/.ssh/id_ed25519.pub"
cat "$HOME/.ssh/id_ed25519_sec.pub"
read -r -p
test -d dotfiles || git clone https://github.com/dddelispt42/dotfiles.git
cd dotfiles || exit
./install.sh
