#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link ${BASEDIR}/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim

# check if XDG_CONFIG_HOME is set - if not set it
if [ -z ${XDG_CONFIG_HOME+x} ]; then
    export XDG_CONFIG_HOME="$HOME/.config/"
    echo "XDG_CONFIG_HOME not defined!!! ... using $XDG_CONFIG_HOME"
fi

# get the bootstrap version for my langs
# curl -s 'http://vim-bootstrap.com/generate.vim' \
#     --data 'langs=javascript&langs=c&langs=html&langs=go&langs=perl&langs=python&langs=rust&editor=nvim' \
#     > ${BASEDIR}/init.vim
curl -s 'http://vim-bootstrap.com/generate.vim' \
    --data 'langs=c&langs=html&langs=python&langs=rust&editor=nvim' \
    > ${BASEDIR}/init.vim

# NeoVIM does not deal with symLinks
sed -i -e "s@\.config\/nvim\/local_@dotfiles\/nvim\/local_@" $BASEDIR/init.vim

# delete double key mappings
sed -i -e '/noremap <leader>q :bp<CR>/d' $BASEDIR/init.vim
sed -i -e '/noremap <leader>w :bn<CR>/d' $BASEDIR/init.vim

# I want backup and swapfiles
sed -i -e 's/set nobackup/set backup/' $BASEDIR/init.vim
sed -i -e 's/set noswapfile/set swapfile/' $BASEDIR/init.vim

# install requirements
# pip3 install --user --upgrade flake8 jedi pylint
# pip2 install --user --upgrade neovim
# pip3 install --user --upgrade neovim

# tuning
sed -i -e "s@\(Plug 'scrooloose\/nerdtree'.*\)@\1, \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'jistr\/vim-nerdtree-tabs'.*\)@\1, \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'majutsushi\/tagbar'.*\)@\1, \{ 'on': 'TagbarToggle' \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'jelera\/vim-javascript-syntax'.*\)@\1, \{ 'for': [ 'javascript' , 'javascript.jsx' ] \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'vim-perl\/vim-perl'.*\)@\1, \{ 'for': 'perl' \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'c9s\/perlomni.vim'.*\)@\1, \{ 'for': 'perl' \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'davidhalter\/jedi-vim'.*\)@\1, \{ 'for': 'python' \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'rust-lang\/rust.vim'.*\)@\1, \{ 'for': 'rust' \}@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'racer-rust\/vim-racer'.*\)@\1, \{ 'for': 'rust' \}@" $BASEDIR/init.vim
# activate upon insert only
sed -i -e "s@\(.*Plug 'SirVer\/ultisnips'.*\)@\1, \{ 'on': [] \}@" $BASEDIR/init.vim
sed -i -e "s@\(.*Plug 'honza\/vim-snippets'.*\)@\1, \{ 'on': [] \}@" $BASEDIR/init.vim
# disabling
sed -i -e "s@\(Plug 'hail2u\/vim-css3-syntax'.*\)@\" \1@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'vim-scripts\/grep.vim'.*\)@\" \1@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'vim-scripts\/CSApprox'.*\)@\" \1@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'mattn\/emmet-vim'.*\)@\" \1@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'sheerun\/vim-polyglot'.*\)@\" \1@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'gorodinskiy\/vim-coloresque'.*\)@\" \1@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'avelino\/vim-bootstrap-updater'.*\)@\" \1@" $BASEDIR/init.vim
sed -i -e "s@\(Plug 'tomasr\/molokai'.*\)@\" \1@" $BASEDIR/init.vim

# cp $BASEDIR/init.vim $BASEDIR/init.vime

# link the config files
mkdir -p ${XDG_CONFIG_HOME}/nvim/
create_dotfile_link ${BASEDIR}/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
create_dotfile_link ${BASEDIR}/local_init.vim ${XDG_CONFIG_HOME}/nvim/local_init.vim
create_dotfile_link ${BASEDIR}/local_bundles.vim ${XDG_CONFIG_HOME}/nvim/local_bundles.vim

# copy to windows versions
if [[ "$OSTYPE" = "cygwin" ]]; then
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
    nvim-qt +PlugInstall +PlugUpdate +PlugClean +qall
fi

# update VIM/NeoVIM
nvim --version | grep Compiled > /dev/null
if [ $? -eq 0 ]; then
    # nvim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
    nvim +PlugInstall +PlugUpdate +PlugClean +qall
fi

# nvim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall

if [ "$OS" = "Windows_NT" ]; then
    sed -i -e "s/'--ansi', //g;s/--ansi //" plugged/fzf.vim/autoload/fzf/vim.vim
    sed -i -e "s/'--header-lines', .*), //g;s/--header-lines=1 //;s/--header-lines[ =]1//" plugged/fzf.vim/autoload/fzf/vim.vim
fi
