#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

# check if XDG_CONFIG_HOME is set - if not set it
if [ -z ${XDG_CONFIG_HOME+x} ]; then
    export XDG_CONFIG_HOME="$HOME/.config/"
    echo "XDG_CONFIG_HOME not defined!!! ... using $XDG_CONFIG_HOME"
fi

# backup all pre-dotfiles configurations
if [ -f $XDG_CONFIG_HOME/nvim/init.vim ] ; then
    mv $XDG_CONFIG_HOME/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim.dotfiles-$(date -I)
fi
if [ -f $XDG_CONFIG_HOME/nvim/local_init.vim ] ; then
    mv $XDG_CONFIG_HOME/nvim/local_init.vim $XDG_CONFIG_HOME/nvim/local_init.vim.dotfiles-$(date -I)
fi
if [ -f $XDG_CONFIG_HOME/nvim/local_bundles.vim ] ; then
    mv $XDG_CONFIG_HOME/nvim/local_bundles.vim $XDG_CONFIG_HOME/nvim/local_bundles.vim.dotfiles-$(date -I)
fi

# backup previsou vim-bootstrap version
# if [ -f $BASEDIR/init.vim ] ; then
#     mv $BASEDIR/init.vim $BASEDIR/init.vim.backup-$(date -I)
# fi

curl -s 'http://vim-bootstrap.com/generate.vim' \
    --data 'langs=javascript&langs=c&langs=html&langs=go&langs=perl&langs=python&langs=rust&editor=nvim' \
    > ${BASEDIR}/init.vim

# NeoVIM does not deal with symLinks
sed -ie "s@\.config\/nvim\/local_@dotfiles\/nvim\/local_@" $BASEDIR/init.vim

# TODO: (heiko) - check if valid vim file (vs. HTML page)

# delete double key mappings
sed -i '/noremap <leader>z :bp<CR>/d' $BASEDIR/init.vim
sed -i '/noremap <leader>x :bn<CR>/d' $BASEDIR/init.vim

# sudo apt-get install git exuberant-ctags ncurses-term curl

# install requirements
pip3 install --user --upgrade flake8 jedi pylint
# pip2 install --user --upgrade neovim
pip3 install --user --upgrade neovim

# update VIM/NeoVIM
# TODO check if exists
nvim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall

# TODO why init.vime???
rm $BASEDIR/init.vime

# tuning
sed -ie "s@Plug 'scrooloose\/nerdtree'.*@Plug 'scrooloose\/nerdtree', \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/init.vim
sed -ie "s@Plug 'jistr\/vim-nerdtree-tabs'.*@Plug 'jistr\/vim-nerdtree-tabs', \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/init.vim
sed -ie "s@Plug 'jelera\/vim-javascript-syntax'.*@Plug 'jelera\/vim-javascript-syntax', \{ 'for': [ 'javascript' , 'javascript.jsx' ] \}@" $BASEDIR/init.vim
sed -ie "s@Plug 'vim-perl\/vim-perl'.*@Plug 'vim-perl\/vim-perl', \{ 'for': 'perl' \}@" $BASEDIR/init.vim
sed -ie "s@Plug 'c9s\/perlomni.vim'.*@Plug 'c9s\/perlomni.vim', \{ 'for': 'perl' \}@" $BASEDIR/init.vim
sed -ie "s@Plug 'davidhalter\/jedi-vim'.*@Plug 'davidhalter\/jedi-vim', \{ 'for': 'python' \}@" $BASEDIR/init.vim
sed -ie "s@Plug 'rust-lang\/rust.vim'.*@Plug 'rust-lang\/rust.vim', \{ 'for': 'rust' \}@" $BASEDIR/init.vim
sed -ie "s@Plug 'racer-rust\/vim-racer'.*@Plug 'racer-rust\/vim-racer', \{ 'for': 'rust' \}@" $BASEDIR/init.vim

cp $BASEDIR/init.vim $BASEDIR/init.vime

# link the config files
mkdir -p ${XDG_CONFIG_HOME}/nvim/
ln -sf ${BASEDIR}/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
ln -sf ${BASEDIR}/local_init.vim ${XDG_CONFIG_HOME}/nvim/local_init.vim
ln -sf ${BASEDIR}/local_bundles.vim ${XDG_CONFIG_HOME}/nvim/local_bundles.vim

# copy to windows versions
if [[ "$OSTYPE" == *"Windows"* ]]; then
    mkdir -p $XDG_CONFIG_HOME/nvim
    echo "Detected Windows --> copy NVIM config to %HOME%\\AppData\\Local\\nvim"
    cp ${BASEDIR}/init.vim ${BASEDIR}/local_init.vim ${BASEDIR}/local_bundles.vim $LOCALAPPDATA/nvim/
    # substitute paths to windows format and location
    sed -i "s/let g:session_directory = \"~\/\.config\/nvim\/session\"/let g:session_directory = \'c:\\\Users\\\\$USER\\\AppData\\\Local\\\nvim\\\session\'/" \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
    sed -i "s/~\/\.config\/nvim\/autoload\//c:\\\Users\\\\$USER\\\AppData\\\Local\\\nvim\\\autostart\\\/" \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
    sed -i "s/~\/\.config\/nvim\//c:\\\Users\\\\$USER\\\AppData\\\Local\\\nvim\\\/" \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
    # set command prompt as default shell
    sed -i 's/set shell=\/.*bin\/sh/set shell=cmd/' \
        $LOCALAPPDATA/nvim/init.vim $LOCALAPPDATA/nvim/local_init.vim $LOCALAPPDATA/nvim/local_bundles.vim
fi

nvim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
