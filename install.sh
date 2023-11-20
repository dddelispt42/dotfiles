#!/bin/bash
ROOTDIR="$(realpath "$(dirname "$0")")"
# FONTURL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/VictorMono.zip"
FONTURL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip"
# FONT="VictorMono"
FONT="FiraCode"

# move things to XDG directories
function migrate_to_clean {
	[[ -f "$1" ]] && [[ ! -f "$2" ]] && mv "$1" "$2" && return
	[[ -d "$1" ]] && [[ ! -d "$2" ]] && mv "$1" "$2"
}

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
mkdir -p "$XDG_MUSIC_DIR"
mkdir -p "$XDG_PICTURES_DIR"
mkdir -p "$XDG_PICTURES_DIR"/screenshots
mkdir -p "$XDG_PUBLICSHARE_DIR"
mkdir -p "$XDG_TEMPLATES_DIR"
mkdir -p "$XDG_VIDEOS_DIR"
mkdir -p "$HOME/.ssh"
migrate_to_clean "$HOME"/.ansible "$XDG_CONFIG_HOME"/ansible
migrate_to_clean "$HOME"/.RFCs "$XDG_CACHE_HOME"/RFCs
migrate_to_clean "$HOME"/.surf "$XDG_CACHE_HOME"/surf
migrate_to_clean "$HOME"/.Skype "$XDG_CONFIG_HOME"/Skype
migrate_to_clean "$HOME"/.aria2 "$XDG_CONFIG_HOME"/aria2
migrate_to_clean "$HOME"/.asoundrc "$XDG_CONFIG_HOME"/asoundrc
migrate_to_clean "$HOME"/.binwalk "$XDG_CONFIG_HOME"/binwalk
migrate_to_clean "$HOME"/.calibre "$XDG_CONFIG_HOME"/calibre
migrate_to_clean "$HOME"/.cargo "$XDG_DATA_HOME"/cargo
migrate_to_clean "$HOME"/.cht.sh "$XDG_CONFIG_HOME"/cht.sh
migrate_to_clean "$HOME"/.cmus "$XDG_CONFIG_HOME"/cmus
migrate_to_clean "$HOME"/.kde "$XDG_CONFIG_HOME"/kde
migrate_to_clean "$HOME"/.gnupg "$XDG_CONFIG_HOME"/gnupg
migrate_to_clean "$HOME"/.gradle "$XDG_DATA_HOME"/gradle
migrate_to_clean "$HOME"/.wget-hsts "$XDG_DATA_HOME"/wget-hsts
migrate_to_clean "$HOME"/.ICEauthority "$XDG_CACHE_HOME"/ICEauthority
migrate_to_clean "$HOME"/.dvdcss "$XDG_DATA_HOME"/dvdcss
mkdir -p "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
migrate_to_clean "$HOME"/.gtkrc-2.0 "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
migrate_to_clean "$HOME"/.gimp-2.0 "$XDG_CONFIG_HOME"/gimp-2.0
migrate_to_clean "$HOME"/.gimp-2.10 "$XDG_CONFIG_HOME"/gimp-2.10
migrate_to_clean "$HOME"/.xbindkeysrc "$XDG_CONFIG_HOME"/xbindkeysrc
migrate_to_clean "$HOME"/.gimp-2.2 "$XDG_CONFIG_HOME"/gimp-2.2
migrate_to_clean "$HOME"/.gimp-2.4 "$XDG_CONFIG_HOME"/gimp-2.4
migrate_to_clean "$HOME"/.gimp-2.6 "$XDG_CONFIG_HOME"/gimp-2.6
migrate_to_clean "$HOME"/.gimp-2.8 "$XDG_CONFIG_HOME"/gimp-2.8
# TODO: works only with xinit not startx
# migrate_to_clean "$HOME"/.xinitrc "$XDG_CONFIG_HOME"/X11/xinitrc
migrate_to_clean "$HOME"/.htoprc "$XDG_CONFIG_HOME"/htoprc
migrate_to_clean "$HOME"/.httpie "$XDG_CONFIG_HOME"/httpie
migrate_to_clean "$HOME"/.i3 "$XDG_CONFIG_HOME"/i3
migrate_to_clean "$HOME"/.i3status.conf "$XDG_CONFIG_HOME"/i3status.conf
migrate_to_clean "$HOME"/.inkscape "$XDG_CONFIG_HOME"/inkscape
migrate_to_clean "$HOME"/.lftp.conf "$XDG_CONFIG_HOME"/lftp.conf
migrate_to_clean "$HOME"/.mc "$XDG_CONFIG_HOME"/mc
migrate_to_clean "$HOME"/.mpdconf "$XDG_CONFIG_HOME"/mpdconf
migrate_to_clean "$HOME"/.mpv "$XDG_CONFIG_HOME"/mpv
migrate_to_clean "$HOME"/.mutt "$XDG_CONFIG_HOME"/mutt
migrate_to_clean "$HOME"/.mypoint "$XDG_CONFIG_HOME"/mypoint
migrate_to_clean "$HOME"/.newsbeuter "$XDG_CONFIG_HOME"/newsbeuter
migrate_to_clean "$HOME"/.weechat "$XDG_CONFIG_HOME"/weechat
migrate_to_clean "$HOME"/.newsboat "$XDG_CONFIG_HOME"/newsboat
migrate_to_clean "$HOME"/.pandoc "$XDG_CONFIG_HOME"/pandoc
migrate_to_clean "$HOME"/.pylint.d "$XDG_CONFIG_HOME"/pylint
migrate_to_clean "$HOME"/.pylintrc "$XDG_CONFIG_HOME"/pylint/pylintrc
migrate_to_clean "$HOME"/.rustup "$XDG_DATA_HOME"/rustup
migrate_to_clean "$HOME"/.minikube "$XDG_DATA_HOME"/minikube
migrate_to_clean "$HOME"/.wget-hsts "$XDG_DATA_HOME"/wget-hsts
migrate_to_clean "$HOME"/.terminfo "$XDG_DATA_HOME"/terminfo
migrate_to_clean "$HOME"/.thumbnails "$XDG_CACHE_HOME"/thumbnails
migrate_to_clean "$HOME"/.zhistory "$XDG_CACHE_HOME"/zhistory
migrate_to_clean "$HOME"/vimfiles "$XDG_CACHE_HOME"/nvim
migrate_to_clean "$HOME"/.pki "$XDG_DATA_HOME"/pki
migrate_to_clean "$HOME"/.pip "$XDG_CONFIG_HOME"/pip
migrate_to_clean "$HOME"/.tmuxp "$XDG_CONFIG_HOME"/tmuxp
mkdir -p "$XDG_CACHE_HOME"/xsel
migrate_to_clean "$HOME"/.xsel.log "$XDG_DATA_HOME"/xsel/log
migrate_to_clean "$HOME"/.vlcrc "$XDG_CONFIG_HOME"/vlcrc
# migrate_to_clean "$HOME"/.VirtualBox "$XDG_CONFIG_HOME"/VirtualBox
migrate_to_clean "$HOME"/.binwalk "$XDG_CONFIG_HOME"/binwalk
migrate_to_clean "$HOME"/.blender "$XDG_CONFIG_HOME"/blender
migrate_to_clean "$HOME"/.mc "$XDG_CONFIG_HOME"/mc
migrate_to_clean "$HOME"/.pip "$XDG_CACHE_HOME"/pip
migrate_to_clean "$HOME"/.pulse "$XDG_CACHE_HOME"/pulse
mkdir -p "$XDG_DATA_HOME"/tig
migrate_to_clean "$HOME"/.tmuxp "$XDG_CONFIG_HOME"/tmuxp
mkdir -p "$XDG_CACHE_HOME"/wget
migrate_to_clean "$HOME"/.wget-hsts "$XDG_CACHE_HOME"/wget/wget-hsts
migrate_to_clean "$HOME"/.inputrc "$XDG_CACHE_HOME"/inputrc
migrate_to_clean "$HOME"/.kodi "$XDG_DATA_HOME"/kodi
migrate_to_clean "$HOME"/.password-store "$XDG_CONFIG_HOME"/password-store
migrate_to_clean "$HOME"/go "$XDG_DATA_HOME"/go
migrate_to_clean "$HOME"/.elinks "$XDG_CONFIG_HOME"/elinks
migrate_to_clean "$HOME"/.docker "$XDG_CONFIG_HOME"/docker
migrate_to_clean "$HOME"/.bogofilter "$XDG_CACHE_HOME"/bogofilter
migrate_to_clean "$HOME"/.rnd "$XDG_CACHE_HOME"/rnd
migrate_to_clean "$HOME"/.z "$XDG_DATA_HOME"/z
migrate_to_clean "$HOME"/.fontconfig "$XDG_CACHE_HOME"/fontconfig
migrate_to_clean "$HOME"/.fonts "$XDG_DATA_HOME"/fonts
mkdir -p "$XDG_CONFIG_HOME"/fontconfig
migrate_to_clean "$HOME"/.fonts.conf "$XDG_CONFIG_HOME"/fontconfig/fonts.conf
migrate_to_clean "$HOME"/.crontab "$XDG_CONFIG_HOME"/crontab
migrate_to_clean "$HOME"/.zshrc.local "$XDG_CONFIG_HOME"/zshrc.local
migrate_to_clean "$HOME"/.sqlite_history "$XDG_DATA_HOME"/sqlite_history
migrate_to_clean "$HOME"/.icons "${XDG_DATA_HOME}"/icons
migrate_to_clean "$HOME"/.myclirc "${XDG_CONFIG_HOME}"/myclirc

stow -vS -t "$HOME"/ X11
stow -vS -t "$HOME"/ alacritty
stow -vS -t "$HOME"/ bat
stow -vS -t "$HOME"/ bottom
stow -vS -t "$HOME"/ broot
stow -vS -t "$HOME"/ dunst
stow -vS -t "$HOME"/ dwm
stow -vS -t "$HOME"/ foot
stow -vS -t "$HOME"/ git
stow -vS -t "$HOME"/ lf
stow -vS -t "$HOME"/ hyprland
stow -vS -t "$HOME"/ mpv
stow -vS -t "$HOME"/ neofetch
stow -vS -t "$HOME"/ nvim
stow -vS -t "$HOME"/ paru
stow -vS -t "$HOME"/ polybar
stow -vS -t "$HOME"/ qutebrowser
stow -vS -t "$HOME"/ ranger
stow -vS -t "$HOME"/ rofi
stow -vS -t "$HOME"/ ruff
stow -vS -t "$HOME"/ sheldon
stow -vS -t "$HOME"/ shell
stow -vS -t "$HOME"/ starship
stow -vS -t "$HOME"/ stylua
stow -vS -t "$HOME"/ tmux
stow -vS -t "$HOME"/ topgrade
stow -vS -t "$HOME"/ vifm
stow -vS -t "$HOME"/ ytfzf
stow -vS -t "$HOME"/ xplr
stow -vS -t "$HOME"/ xsuspender
stow -vS -t "$HOME"/ zathura
stow -vS -t "$HOME"/ zsh

# add links
cd ~/opt || echo "Missing ~/opt directory"
test -s ../dev/heiko/backmatic/target/release/backmatic && ln -sf "$_" backmatic
test -s ../dev/security/gitleaks/gitleaks && ln -sf "$_" gitleaks
test -s ../dev/heiko/gtd/target/release/gtd && ln -sf "$_" gtd
test -s ../dev/heiko/hwm/target/release/hwm && ln -sf "$_" hwm
test -s ../dev/base/quite-intriguing/quite-intriguing && ln -sf "$_" qi
test -s ../dev/base/quite-intriguing/quite-intriguing-preview && ln -sf "$_" quite-intriguing-preview
test -s ../dev/cli/sc-im/src/sc-im && ln -sf "$_" sc-im
test -s ../dev/rice/theme.sh/bin/theme.sh && ln -sf "$_" theme.sh
test -s ../dev/heiko/dotfiles/lf/.config/lf/preview.sh && ln -sf "$_" preview.sh
test -s ../dev/heiko/dotfiles/lf/.config/lf/open.sh && ln -sf "$_" open.sh
cd - || echo "Missing previous directory"

# copy vs. stow
cp -f ./user-dirs/.config/* "$XDG_CONFIG_HOME"

stow -vD -t "$HOME"/ btop >&/dev/null
mkdir -p "$XDG_CONFIG_HOME"/btop
cp ./btop/.config/btop/btop.conf "$XDG_CONFIG_HOME"/btop

stow -vD -t "$HOME"/ htop >&/dev/null
mkdir -p "$XDG_CONFIG_HOME"/htop
cp ./htop/.config/htop/htoprc "$XDG_CONFIG_HOME"/htop

# no longer used
stow -vD -t "$HOME"/ flake8 >&/dev/null
stow -vD -t "$HOME"/ pycodestyle >&/dev/null
stow -vD -t "$HOME"/ pylint >&/dev/null

# if [ "$OSTYPE" = "linux-android" ]; then
# 	stow -vS -t "$HOME"/ android # Android
# fi

sheldon lock --update

if command -v xdg-mime >/dev/null; then
	xdg-mime default org.pwmt.zathura.desktop application/pdf
fi

if [ ! -f "${XDG_DATA_HOME}/fonts/${FONT}NerdFont-Regular.ttf" ]; then
	echo "Installing ${FONT}..."
	if cd "$(mktemp -d)"; then
		wget "$FONTURL"
		unzip "${FONT}.zip"
		mv ./*.ttf "${XDG_DATA_HOME}/fonts"
		fc-cache -fv
		cd - || true
	fi
fi

mkdir -p "$XDG_STATE_HOME"/nvim/{undo,backup,swap,sessions,spell}
if command -v nvim >/dev/null; then
	cd "$XDG_DATA_HOME/nvim/lazy/neogit" || echo "Neogit dir not found"
	git co -- doc/tags 2>/dev/null
	cd "$XDG_DATA_HOME/nvim/lazy/rest.nvim" || echo "rest.nvim dir not found"
	git co -- doc/tags 2>/dev/null
	cd "$ROOTDIR" || true
	nvim --headless "+Lazy! sync" +qa
	nvim --headless "+Lazy! sync" +qa
	nvim --headless "+Lazy! sync" +qa
	nvim --headless "+MasonUpdate" +qa
fi

# TODO: check if key is too old
test -s "$HOME/.ssh/id_ed25519" || ssh-keygen -t ed25519 -C "$(whoami)@$(cat /etc/hostname)-$(date -I)" -a 100
test -s "$HOME/.ssh/id_ed25519_sec" || ssh-keygen -t ed25519 -C "$(whoami)@$(cat /etc/hostname)-$(date -I)-sec" -f "$HOME/.ssh/id_ed25519_sec" -a 100
echo "Add public key to authorized_keys for git server:"
cat "$HOME/.ssh/id_ed25519.pub"
cat "$HOME/.ssh/id_ed25519_sec.pub"
# TODO: only if new key was generated
# read -p "Add public key to git server..." yn
mkdir -p "$HOME/dev/heiko"

# copy to Windows if exiting
if test -d /mnt/users/hriemer/AppData/Local/nvim/; then
	cp "$HOME"/dev/heiko/dotfiles/nvim/.config/nvim/init.vim /mnt/users/hriemer/AppData/Local/nvim/
	mkdir -p /mnt/users/hriemer/AppData/Local/nvim/lua/
	cp "$HOME"/dev/heiko/dotfiles/nvim/.config/nvim/lua/* /mnt/users/hriemer/AppData/Local/nvim/lua/
	cp "${XDG_CONFIG_HOME:-$HOME/.config}"/git/* /mnt/users/hriemer/.config/git/
fi
if test -d /mnt/users/hriemer/.config/vifm/; then
	rsync -av --delete vifm/.config/vifm/ /mnt/users/hriemer/AppData/Roaming/Vifm/
fi
if test -d /mnt/users/hriemer/AppData/Roaming/yazi/config; then
	rsync -av --delete "$ROOTDIR/yazi/.config/yazi/" /mnt/users/hriemer/AppData/Roaming/yazi/config
fi

git submodule update --init vifm/.config/vifm/colors/

# protect settings dir
chmod 700 "$HOME/.cache" "$HOME/.config" "$HOME/.ssh"

# tmux tpm
git submodule update --init tmux/.config/tmux/plugins/tpm
"$ROOTDIR"/tmux/.config/tmux/plugins/tpm/bin/install_plugins
"$ROOTDIR"/tmux/.config/tmux/plugins/tpm/bin/update_plugins all
"$ROOTDIR"/tmux/.config/tmux/plugins/tpm/bin/clean_plugins
