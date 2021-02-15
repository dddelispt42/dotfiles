#!/bin/bash

# clean up legacy manual links - pre stow
[[ -L ~/.ignore ]] && trash ~/.ignore
[[ -L ~/.agignore ]] && trash ~/.agignore
[[ -L ~/.rgignore ]] && trash ~/.rgignore
[[ -L ~/.gitignore ]] && trash ~/.gitignore
[[ -L ~/.gitconfig ]] && trash ~/.gitconfig
[[ -L ~/.profile ]] && trash ~/.profile
# [[ -L ~/.bashrc ]] && trash ~/.bashrc
# [[ -L ~/.bash_profile ]] && trash ~/.bash_profile
# [[ -L ~/.bash_logout ]] && trash ~/.bash_logout
[[ -f ~/.config/liquidpromptrc ]] && trash ~/.config/liquidpromptrc
[[ -f ~/.agent.sh ]] && trash ~/.agent.sh
[[ -d ~/.config/bat ]] && trash ~/.config/bat
[[ -L ~/.config/bspwm ]] && trash ~/.config/bspwm
[[ -L ~/.config/dunst ]] && trash ~/.config/dunst
[[ -L ~/.config/lf ]] && trash ~/.config/lf
[[ -L ~/.config/polybar ]] && trash ~/.config/polybar
[[ -L ~/.config/sxhkd ]] && trash ~/.config/sxhkd
[[ -L ~/.screenrc ]] && trash ~/.screenrc
# [[ -L ~/.tmux.conf ]] && trash ~/.tmux.conf
[[ -L ~/.tmuxinator ]] && trash ~/.tmuxinator
[[ -L ~/.config/nvim ]] && trash ~/.config/nvim
[[ -L ~/.config/nvim/UltiSnips ]] && trash ~/.config/nvim/UltiSnips
# [[ -L ~/.vimrc ]] && trash ~/.vimrc
[[ -L ~/.vim ]] && trash ~/.vim
[[ -L ~/.nvim ]] && trash ~/.nvim
[[ -L ~/.nvimrc ]] && trash ~/.nvimrc
[[ -L ~/.vim/UltiSnips ]] && trash ~/.vim/UltiSnips
[[ -L ~/.config/nvim/init.vim ]] && trash ~/.config/nvim/init.vim
[[ -L ~/.config/nvim/local_bundles.vim ]] && trash ~/.config/nvim/local_bundles.vim
[[ -L ~/.config/nvim/local_init.vim ]] && trash ~/.config/nvim/local_init.vim
[[ -d ~/dotfiles/bash/liquidprompt ]] && trash ~/dotfiles/bash/liquidprompt
[[ -d ~/dotfiles/zsh/oh-my-zsh ]] && trash ~/dotfiles/zsh/oh-my-zsh
[[ -d ~/dotfiles/zsh/zplug ]] && trash ~/dotfiles/zsh/zplug
[[ -L ~/.zshrc ]] && trash ~/.zshrc
[[ -L ~/.zshenv ]] && trash ~/.zshenv
[[ -L ~/.p10k.zsh ]] && trash ~/.p10k.zsh

# move things to XDG directories
function migrate_to_clean {
    [[ -f "$1" ]] && [[ ! -f "$2" ]] && mv "$1" "$2" && return
    [[ -d "$1" ]] && [[ ! -d "$2" ]] && mv "$1" "$2"
}
# migrate_to_clean ~/.zplug "$XDG_CACHE_HOME"/zplug
migrate_to_clean ~/.RFCs "$XDG_CACHE_HOME"/RFCs
migrate_to_clean ~/.Skype "$XDG_CONFIG_HOME"/Skype
migrate_to_clean ~/.aria2 "$XDG_CONFIG_HOME"/aria2
migrate_to_clean ~/.asoundrc "$XDG_CONFIG_HOME"/asoundrc
migrate_to_clean ~/.binwalk "$XDG_CONFIG_HOME"/binwalk
migrate_to_clean ~/.calibre "$XDG_CONFIG_HOME"/calibre
migrate_to_clean ~/.cargo "$XDG_DATA_HOME"/cargo
migrate_to_clean ~/.cht.sh "$XDG_CONFIG_HOME"/cht.sh
migrate_to_clean ~/.cmus "$XDG_CONFIG_HOME"/cmus
migrate_to_clean ~/.gimp-2.0 "$XDG_CONFIG_HOME"/gimp-2.0
migrate_to_clean ~/.gimp-2.10 "$XDG_CONFIG_HOME"/gimp-2.10
migrate_to_clean ~/.gimp-2.2 "$XDG_CONFIG_HOME"/gimp-2.2
migrate_to_clean ~/.gimp-2.4 "$XDG_CONFIG_HOME"/gimp-2.4
migrate_to_clean ~/.gimp-2.6 "$XDG_CONFIG_HOME"/gimp-2.6
migrate_to_clean ~/.gimp-2.8 "$XDG_CONFIG_HOME"/gimp-2.8
migrate_to_clean ~/.htoprc "$XDG_CONFIG_HOME"/htoprc
migrate_to_clean ~/.httpie "$XDG_CONFIG_HOME"/httpie
migrate_to_clean ~/.i3 "$XDG_CONFIG_HOME"/i3
migrate_to_clean ~/.i3status.conf "$XDG_CONFIG_HOME"/i3status.conf
migrate_to_clean ~/.inkscape "$XDG_CONFIG_HOME"/inkscape
migrate_to_clean ~/.lftp.conf "$XDG_CONFIG_HOME"/lftp.conf
migrate_to_clean ~/.mc "$XDG_CONFIG_HOME"/mc
migrate_to_clean ~/.mpdconf "$XDG_CONFIG_HOME"/mpdconf
migrate_to_clean ~/.mpv "$XDG_CONFIG_HOME"/mpv
migrate_to_clean ~/.mutt "$XDG_CONFIG_HOME"/mutt
migrate_to_clean ~/.mypoint "$XDG_CONFIG_HOME"/mypoint
migrate_to_clean ~/.newsbeuter "$XDG_CONFIG_HOME"/newsbeuter
migrate_to_clean ~/.newsboat "$XDG_CONFIG_HOME"/newsboat
migrate_to_clean ~/.pandoc "$XDG_CONFIG_HOME"/pandoc
migrate_to_clean ~/.pylint.d "$XDG_CONFIG_HOME"/pylint
migrate_to_clean ~/.pylintrc "$XDG_CONFIG_HOME"/pylint/pylintrc
migrate_to_clean ~/.rustup "$XDG_DATA_HOME"/rustup
migrate_to_clean ~/.thumbnails "$XDG_CACHE_HOME"/thumbnails
migrate_to_clean ~/.zhistory "$XDG_CACHE_HOME"/zhistory
migrate_to_clean ~/vimfiles "$XDG_CACHE_HOME"/nvim
migrate_to_clean ~/.pki "$XDG_DATA_HOME"/pki
migrate_to_clean ~/.pip "$XDG_CONFIG_HOME"/pip
migrate_to_clean ~/.tmuxp "$XDG_CONFIG_HOME"/tmuxp
mkdir -p "$XDG_CACHE_HOME"/xsel
migrate_to_clean ~/.xsel.log "$XDG_DATA_HOME"/xsel/log
migrate_to_clean ~/.vlcrc "$XDG_CONFIG_HOME"/vlcrc
migrate_to_clean ~/.VirtualBox "$XDG_CONFIG_HOME"/VirtualBox
migrate_to_clean ~/.binwalk "$XDG_CONFIG_HOME"/binwalk
migrate_to_clean ~/.blender "$XDG_CONFIG_HOME"/blender
migrate_to_clean ~/.mc "$XDG_CONFIG_HOME"/mc
migrate_to_clean ~/.pip "$XDG_CACHE_HOME"/pip
migrate_to_clean ~/.pulse "$XDG_CACHE_HOME"/pulse
mkdir -p "$XDG_DATA_HOME"/tig
migrate_to_clean ~/.tmuxp "$XDG_CONFIG_HOME"/tmuxp
migrate_to_clean ~/.VirtualBox "$XDG_CONFIG_HOME"/VirtualBox
mkdir -p "$XDG_CACHE_HOME"/wget
migrate_to_clean ~/.wget-hsts "$XDG_CACHE_HOME"/wget/wget-hsts
migrate_to_clean ~/.inputrc "$XDG_CACHE_HOME"/inputrc
migrate_to_clean ~/.kodi "$XDG_DATA_HOME"/kodi
migrate_to_clean ~/.password-store "$XDG_CONFIG_HOME"/password-store
migrate_to_clean ~/go "$XDG_DATA_HOME"/go
migrate_to_clean ~/.elinks "$XDG_CONFIG_HOME"/elinks
migrate_to_clean ~/.docker "$XDG_CONFIG_HOME"/docker
migrate_to_clean ~/.bogofilter "$XDG_CACHE_HOME"/bogofilter
migrate_to_clean ~/.rnd "$XDG_CACHE_HOME"/rnd
migrate_to_clean ~/.z "$XDG_DATA_HOME"/z
migrate_to_clean ~/.fontconfig "$XDG_CACHE_HOME"/fontconfig
migrate_to_clean ~/.fonts "$XDG_DATA_HOME"/fonts
mkdir -p "$XDG_CONFIG_HOME"/fontconfig
migrate_to_clean ~/.fonts.conf "$XDG_CONFIG_HOME"/fontconfig/fonts.conf
migrate_to_clean ~/.crontab "$XDG_CONFIG_HOME"/crontab
migrate_to_clean ~/.zshrc.local "$XDG_CONFIG_HOME"/zshrc.local
migrate_to_clean ~/.sqlite_history "$XDG_DATA_HOME"/sqlite_history
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_DESKTOP_DIR"
mkdir -p "$XDG_DOWNLOAD_DIR"
mkdir -p "$XDG_TEMPLATES_DIR"
mkdir -p "$XDG_PUBLICSHARE_DIR"
mkdir -p "$XDG_DOCUMENTS_DIR"
mkdir -p "$XDG_MUSIC_DIR"
mkdir -p "$XDG_PICTURES_DIR"
mkdir -p "$XDG_VIDEOS_DIR"
mkdir -p "$XDG_PICTURES_DIR"/screenshots

stow -vS -t ~/ X11
stow -vS -t ~/ bat
stow -vS -t ~/ bottom
stow -vS -t ~/ broot
stow -vS -t ~/ bspwm
stow -vS -t ~/ dunst
stow -vS -t ~/ dwm
stow -vS -t ~/ flake8
stow -vS -t ~/ git
stow -vS -t ~/ htop
stow -vS -t ~/ lf
stow -vS -t ~/ mpv
stow -vS -t ~/ neofetch
stow -vS -t ~/ nvim
stow -vS -t ~/ polybar
stow -vS -t ~/ pycodestyle
stow -vS -t ~/ pylint
stow -vS -t ~/ ranger
stow -vS -t ~/ rofi
stow -vS -t ~/ shell
stow -vS -t ~/ starship
stow -vS -t ~/ sxhkd
stow -vS -t ~/ tmux
stow -vS -t ~/ user-dirs
stow -vS -t ~/ zathura
stow -vS -t ~/ zsh
xdg-mime default org.pwmt.zathura.desktop application/pdf

# ln -sf "$XDG_CONFIG_HOME"/tmux/tmux.conf ~/.tmux.conf
ln -sf "$XDG_DATA_HOME"/z ~/.z

mkdir -p "$XDG_CACHE_HOME"/vim/{undo,backup,swap,sessions}
if command -v nvim > /dev/null; then
    # nvim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
    nvim +PackerInstall +PlugSync +qall
else
    vim +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
fi

# protect settings dir
chmod 700 "$HOME/.cache" "$HOME/.config"
