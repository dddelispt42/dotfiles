#!/bin/bash
ROOTDIR="$(realpath "$(dirname "$0")")"
NERDFONT_VERSION="v3.4.0"
declare -a fonts=("VictorMono" "Iosevka" "IosevkaTerm" "ZedMono" "FiraCode")

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_DATA_HOME:-$HOME/.local/state}
export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/docs/desktop}
export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/docs}
export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/dl}
export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/media/music}
export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/media/pix}
export XDG_PUBLICSHARE_DIR=${XDG_PUBLICSHARE_DIR:-$HOME/media/public}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$UID}
export XDG_TEMPLATES_DIR=${XDG_TEMPLATES_DIR:-$HOME/media/temp}
export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/media/videos}

mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"
mkdir -p "$XDG_DESKTOP_DIR"
mkdir -p "$XDG_DOCUMENTS_DIR"
mkdir -p "$XDG_DOWNLOAD_DIR"
mkdir -p "$XDG_MUSIC_DIR" 2>/dev/null
mkdir -p "$XDG_PICTURES_DIR"
mkdir -p "$XDG_PICTURES_DIR"/screenshots
mkdir -p "$XDG_PUBLICSHARE_DIR"
mkdir -p "$XDG_TEMPLATES_DIR"
mkdir -p "$XDG_VIDEOS_DIR"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# stow what does not start with "_"
fd -t d --max-depth 1 --regex "^[^_]" -x stow --dotfiles -vS -t "$HOME"/ "{/}"
# unstow what starts with "_"
fd -t d --max-depth 1 --regex "^_" -x stow -vD -t "$HOME"/ "{/}"

bat cache --build 1>/dev/null

# add links
test -d "${HOME}/opt" || mkdir -p "$_"
cd ~/opt || echo "Missing ~/opt directory"
test -s ../dev/base/quite-intriguing/quite-intriguing && ln -sf "$_" qi
test -s ../dev/base/quite-intriguing/quite-intriguing-preview && ln -sf "$_" quite-intriguing-preview
test -s ../dev/cli/sc-im/src/sc-im && ln -sf "$_" sc-im
test -s ../dev/rice/theme.sh/bin/theme.sh && ln -sf "$_" theme.sh
test -s ../dev/heiko/dotfiles/lf/dot-config/lf/preview.sh && ln -sf "$_" preview.sh
test -s ../dev/heiko/dotfiles/lf/dot-config/lf/open.sh && ln -sf "$_" open.sh
cd - || echo "Missing previous directory"

# copy vs. stow
cp -f ./_user-dirs/dot-config/* "$XDG_CONFIG_HOME"/

stow --dotfiles -vD -t "$HOME"/ btop >&/dev/null
mkdir -p "$XDG_CONFIG_HOME"/btop
cp ./_btop/dot-config/btop/btop.conf "$XDG_CONFIG_HOME"/btop

stow --dotfiles -vD -t "$HOME"/ htop >&/dev/null
mkdir -p "$XDG_CONFIG_HOME"/htop
cp ./_htop/dot-config/htop/htoprc "$XDG_CONFIG_HOME"/htop

# if [ "$OSTYPE" = "linux-android" ]; then
# 	stow -vS -t "$HOME"/ android # Android
# fi

sheldon lock --update

if command -v xdg-mime >/dev/null; then
	xdg-mime default org.pwmt.zathura.desktop application/pdf
fi

test -d "${XDG_DATA_HOME}/fonts" || mkdir -p "$_"
if command -v fc-cache >/dev/null; then
	for font in "${fonts[@]}"; do
		if [ ! -f "${XDG_DATA_HOME}/fonts/${font}NerdFont-Regular.ttf" ]; then
			echo "Installing ${font}..."
			if cd "$(mktemp -d)"; then
				wget "https://github.com/ryanoasis/nerd-fonts/releases/download/${NERDFONT_VERSION}/${font}.zip"
				unzip "${font}.zip"
				mv ./*.ttf "${XDG_DATA_HOME}/fonts"
				fc-cache -fv
				cd - || true
			fi
		fi
	done
fi

mkdir -p "$XDG_STATE_HOME"/nvim/{undo,backup,swap,sessions,spell} &>/dev/null
if command -v nvim >/dev/null; then
	cd "$ROOTDIR" || true
	nvim --headless "+Lazy! sync" +qa &>/dev/null
	nvim --headless "+MasonUpdate" +qa &>/dev/null
	nvim --headless "+MasonToolsUpdate" +qa &>/dev/null
	nvim --headless "+TSUpdate" +qa &>/dev/null
fi

test -s "$HOME/.ssh/id_ed25519" || ssh-keygen -t ed25519 -C "$(whoami)@$(cat /etc/hostname)-$(date -I)" -a 100
test -s "$HOME/.ssh/id_ed25519_sec" || ssh-keygen -t ed25519 -C "$(whoami)@$(cat /etc/hostname)-$(date -I)-sec" -f "$HOME/.ssh/id_ed25519_sec" -a 100
echo "Add public key to authorized_keys for git server:"
cat "$HOME/.ssh/id_ed25519.pub"
cat "$HOME/.ssh/id_ed25519_sec.pub"
mkdir -p "$HOME/dev/heiko" &>/dev/null

if command -v age >/dev/null; then
	mkdir -p "${XDG_CONFIG_HOME}/age"
	keyfile="${XDG_CONFIG_HOME}/age/${USER}@$(hostname).txt"
	if ! [ -f "$keyfile" ]; then
		age-keygen -o "$keyfile"
		chmod 600 "$keyfile"
		if command -v paper-age >/dev/null; then
			if [ ! -f "${keyfile}.pdf" ] || [ "$keyfile" -nt "${keyfile}.pdf" ]; then
				echo "Creating paper backup of age key..."
				paper-age -t "$keyfile" "$keyfile" -o "${keyfile}.pdf"
			fi
		fi
	fi
	keyfile="${XDG_CONFIG_HOME}/age/${USER}@$(hostname).age"
	if ! [ -f "$keyfile" ]; then
		age-keygen | age -p >"$keyfile"
		chmod 600 "$keyfile"
		if command -v paper-age >/dev/null; then
			if [ ! -f "${keyfile}.pdf" ] || [ "$keyfile" -nt "${keyfile}.pdf" ]; then
				echo "Creating paper backup of age key..."
				paper-age -t "$keyfile" "$keyfile" -o "${keyfile}.pdf"
			fi
		fi
	fi
fi
# TODO(heiko): check if there is yubikey and generate sk keys for age/ssh

# TODO: clone directly in Windows vs. copy from VM
# copy to Windows if exiting
if test -d /mnt/users/hriemer/AppData/Local/nvim/; then
	# cp "$HOME"/dev/heiko/dotfiles/nvim/dot-config/nvim/init.vim /mnt/users/hriemer/AppData/Local/nvim/
	# mkdir -p /mnt/users/hriemer/AppData/Local/nvim/lua/
	# cp "$HOME"/dev/heiko/dotfiles/nvim/dot-config/nvim/lua/* /mnt/users/hriemer/AppData/Local/nvim/lua/
	cp "${XDG_CONFIG_HOME:-$HOME/.config}"/git/* /mnt/users/hriemer/.config/git/
fi

# protect settings dir
chmod 700 "$HOME/.cache" "$HOME/.config" "$HOME/.ssh"

# tmux tpm
git submodule update --init tmux/dot-config/tmux/plugins/tpm
"$ROOTDIR"/tmux/dot-config/tmux/plugins/tpm/bin/install_plugins | grep -vE "^Already installed"
"$ROOTDIR"/tmux/dot-config/tmux/plugins/tpm/bin/update_plugins all | grep -vE "(update success|Already up to date)"
"$ROOTDIR"/tmux/dot-config/tmux/plugins/tpm/bin/clean_plugins

if tty -s; then
	if command -v xdg-ninja >/dev/null; then
		xdg-ninja --skip-unsupported
	fi
fi
