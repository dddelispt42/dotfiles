#!/bin/bash

# clean up legacy manual links - pre stow
# [[ -L ~/.ignore ]] && trash ~/.ignore
# [[ -L ~/.agignore ]] && trash ~/.agignore
# [[ -L ~/.rgignore ]] && trash ~/.rgignore
# [[ -L ~/.gitignore ]] && trash ~/.gitignore
# [[ -L ~/.gitconfig ]] && trash ~/.gitconfig
# [[ -L ~/.profile ]] && trash ~/.profile
# [[ -L ~/.bashrc ]] && trash ~/.bashrc
# [[ -L ~/.bash_profile ]] && trash ~/.bash_profile
# [[ -L ~/.bash_logout ]] && trash ~/.bash_logout
# [[ -f ~/.config/liquidpromptrc ]] && trash ~/.config/liquidpromptrc
# [[ -f ~/.agent.sh ]] && trash ~/.agent.sh
# [[ -d ~/.config/bat ]] && trash ~/.config/bat
# [[ -L ~/.config/bspwm ]] && trash ~/.config/bspwm
# [[ -L ~/.config/dunst ]] && trash ~/.config/dunst
# [[ -L ~/.config/lf ]] && trash ~/.config/lf
# [[ -L ~/.config/polybar ]] && trash ~/.config/polybar
# [[ -L ~/.config/sxhkd ]] && trash ~/.config/sxhkd
# [[ -L ~/.screenrc ]] && trash ~/.screenrc
# [[ -L ~/.tmux.conf ]] && trash ~/.tmux.conf
# [[ -L ~/.tmuxinator ]] && trash ~/.tmuxinator
# [[ -L ~/.config/nvim ]] && trash ~/.config/nvim
# [[ -L ~/.config/nvim/UltiSnips ]] && trash ~/.config/nvim/UltiSnips
# [[ -L ~/.vimrc ]] && trash ~/.vimrc
# [[ -L ~/.vim ]] && trash ~/.vim
# [[ -L ~/.nvim ]] && trash ~/.nvim
# [[ -L ~/.nvimrc ]] && trash ~/.nvimrc
# [[ -L ~/.vim/UltiSnips ]] && trash ~/.vim/UltiSnips
# [[ -L ~/.config/nvim/init.vim ]] && trash ~/.config/nvim/init.vim
# [[ -L ~/.config/nvim/local_bundles.vim ]] && trash ~/.config/nvim/local_bundles.vim
# [[ -L ~/.config/nvim/local_init.vim ]] && trash ~/.config/nvim/local_init.vim
# [[ -d ~/dotfiles/bash/liquidprompt ]] && trash ~/dotfiles/bash/liquidprompt
# [[ -d ~/dotfiles/zsh/oh-my-zsh ]] && trash ~/dotfiles/zsh/oh-my-zsh
# [[ -d ~/dotfiles/zsh/zplug ]] && trash ~/dotfiles/zsh/zplug
# [[ -L ~/.zshrc ]] && trash ~/.zshrc
# [[ -L ~/.zshenv ]] && trash ~/.zshenv
# [[ -L ~/.p10k.zsh ]] && trash ~/.p10k.zsh

# move things to XDG directories
function migrate_to_clean {
    [[ -f "$1" ]] && [[ ! -f "$2" ]] && mv "$1" "$2" && return
    [[ -d "$1" ]] && [[ ! -d "$2" ]] && mv "$1" "$2"
}
# migrate_to_clean $HOME/.zplug "$XDG_CACHE_HOME"/zplug
migrate_to_clean "$HOME"/.RFCs "$XDG_CACHE_HOME"/RFCs
migrate_to_clean "$HOME"/.Skype "$XDG_CONFIG_HOME"/Skype
migrate_to_clean "$HOME"/.aria2 "$XDG_CONFIG_HOME"/aria2
migrate_to_clean "$HOME"/.asoundrc "$XDG_CONFIG_HOME"/asoundrc
migrate_to_clean "$HOME"/.binwalk "$XDG_CONFIG_HOME"/binwalk
migrate_to_clean "$HOME"/.calibre "$XDG_CONFIG_HOME"/calibre
migrate_to_clean "$HOME"/.cargo "$XDG_DATA_HOME"/cargo
migrate_to_clean "$HOME"/.cht.sh "$XDG_CONFIG_HOME"/cht.sh
migrate_to_clean "$HOME"/.cmus "$XDG_CONFIG_HOME"/cmus
migrate_to_clean "$HOME"/.gimp-2.0 "$XDG_CONFIG_HOME"/gimp-2.0
migrate_to_clean "$HOME"/.gimp-2.10 "$XDG_CONFIG_HOME"/gimp-2.10
migrate_to_clean "$HOME"/.gimp-2.2 "$XDG_CONFIG_HOME"/gimp-2.2
migrate_to_clean "$HOME"/.gimp-2.4 "$XDG_CONFIG_HOME"/gimp-2.4
migrate_to_clean "$HOME"/.gimp-2.6 "$XDG_CONFIG_HOME"/gimp-2.6
migrate_to_clean "$HOME"/.gimp-2.8 "$XDG_CONFIG_HOME"/gimp-2.8
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
migrate_to_clean "$HOME"/.newsboat "$XDG_CONFIG_HOME"/newsboat
migrate_to_clean "$HOME"/.pandoc "$XDG_CONFIG_HOME"/pandoc
migrate_to_clean "$HOME"/.pylint.d "$XDG_CONFIG_HOME"/pylint
migrate_to_clean "$HOME"/.pylintrc "$XDG_CONFIG_HOME"/pylint/pylintrc
migrate_to_clean "$HOME"/.rustup "$XDG_DATA_HOME"/rustup
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
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_DESKTOP_DIR"
mkdir -p "$XDG_DOCUMENTS_DIR"
mkdir -p "$XDG_DOWNLOAD_DIR"
mkdir -p "$XDG_MUSIC_DIR"
mkdir -p "$XDG_PICTURES_DIR"
mkdir -p "$XDG_PICTURES_DIR"/screenshots
mkdir -p "$XDG_PUBLICSHARE_DIR"
mkdir -p "$XDG_TEMPLATES_DIR"
mkdir -p "$XDG_VIDEOS_DIR"

stow -vS -t "$HOME"/ X11
stow -vS -t "$HOME"/ bat
stow -vS -t "$HOME"/ bottom
stow -vS -t "$HOME"/ broot
stow -vS -t "$HOME"/ bspwm
stow -vS -t "$HOME"/ dunst
stow -vS -t "$HOME"/ dwm
stow -vS -t "$HOME"/ flake8
stow -vS -t "$HOME"/ git
stow -vS -t "$HOME"/ htop
stow -vS -t "$HOME"/ lf
stow -vS -t "$HOME"/ mpv
stow -vS -t "$HOME"/ neofetch
stow -vS -t "$HOME"/ nvim
stow -vS -t "$HOME"/ paru
stow -vS -t "$HOME"/ polybar
stow -vS -t "$HOME"/ pycodestyle
stow -vS -t "$HOME"/ pylint
stow -vS -t "$HOME"/ ranger
stow -vS -t "$HOME"/ rofi
stow -vS -t "$HOME"/ shell
stow -vS -t "$HOME"/ starship
stow -vS -t "$HOME"/ sxhkd
stow -vS -t "$HOME"/ tmux
# stow -vS -t "$HOME"/ user-dirs
cp -f ./user-dirs/.config/* "$XDG_CONFIG_HOME"
stow -vS -t "$HOME"/ zathura
stow -vS -t "$HOME"/ zsh
if command -v xdg-mime > /dev/null; then
    xdg-mime default org.pwmt.zathura.desktop application/pdf
fi

# ln -sf "$XDG_CONFIG_HOME"/tmux/tmux.conf $HOME/.tmux.conf
# TODO: remove once no longer needed
ln -sf "$XDG_DATA_HOME"/z "$HOME"/.z

mkdir -p "$XDG_CACHE_HOME"/vim/{undo,backup,swap,sessions,spell}
if command -v nvim > /dev/null; then
    # nvim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
    # nvim +PackerInstall +PackerSync +qall --headless
    nvim +PackerInstall +qall --headless
else
    vim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
fi

# copy to Windows if exiting
if test -d /mnt/users/hriemer/AppData/Local/nvim/; then
    cp "$HOME"/dev/heiko/dotfiles/nvim/.config/nvim/init.vim /mnt/users/hriemer/AppData/Local/nvim/
    mkdir -p /mnt/users/hriemer/AppData/Local/nvim/lua/
    cp "$HOME"/dev/heiko/dotfiles/nvim/.config/nvim/lua/* /mnt/users/hriemer/AppData/Local/nvim/lua/
fi

# protect settings dir
chmod 700 "$HOME/.cache" "$HOME/.config"
