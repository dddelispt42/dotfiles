#!/bin/bash
BASEDIR=$(pwd)/$(dirname "$0")

if [ -d ~/.vim ] ; then
    mv ~/.vim ~/.vim.dotfiles-$(date -I)
fi
if [ -f ~/.vimrc ] ; then
    mv ~/.vimrc ~/.vimrc.dotfiles-$(date -I)
fi
if [ -f ~/.vimrc.local ] ; then
    mv ~/.vimrc.local ~/.vimrc.local.dotfiles-$(date -I)
fi
if [ -f ~/.vimrc.bundle ] ; then
    mv ~/.vimrc.bundle ~/.vimrc.bundle.dotfiles-$(date -I)
fi

ln -sfn $BASEDIR ~/.vim
ln -sf ${BASEDIR}/vimrc ~/.vimrc
ln -sf ${BASEDIR}/../nvim/local_init.vim ~/.vimrc.local
ln -sf ${BASEDIR}/../nvim/local_bundles.vim ~/.vimrc.local.bundles

# TODO: (heiko) - check if valid vim file (vs. HTML page)

curl -s 'http://vim-bootstrap.com/generate.vim' \
    --data 'langs=javascript&langs=c&langs=html&langs=go&langs=perl&langs=python&langs=rust&editor=vim' \
    > ${BASEDIR}/vimrc

# delete double key mappings
sed -i '/noremap <leader>q :bp<CR>/d' $BASEDIR/vimrc
sed -i '/noremap <leader>w :bn<CR>/d' $BASEDIR/vimrc

# sudo apt-get install git exuberant-ctags ncurses-term curl

# install requirements
pip3 install --user --upgrade flake8 jedi pylint
# pip2 install --user --upgrade neovim
pip3 install --user --upgrade neovim

# TODO: (heiko) - check if plantuml.jar is in bin and create plantuml.sh

# update VIM/NeoVIM
# TODO check if exists
vim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall

# tuning
sed -ie "s@Plug 'scrooloose\/nerdtree'.*@Plug 'scrooloose\/nerdtree', \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/vimrc
sed -ie "s@Plug 'jistr\/vim-nerdtree-tabs'.*@Plug 'jistr\/vim-nerdtree-tabs', \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/vimrc
sed -ie "s@Plug 'jelera\/vim-javascript-syntax'.*@Plug 'jelera\/vim-javascript-syntax', \{ 'for': [ 'javascript' , 'javascript.jsx' ] \}@" $BASEDIR/vimrc
sed -ie "s@Plug 'vim-perl\/vim-perl'.*@Plug 'vim-perl\/vim-perl', \{ 'for': 'perl' \}@" $BASEDIR/vimrc
sed -ie "s@Plug 'c9s\/perlomni.vim'.*@Plug 'c9s\/perlomni.vim', \{ 'for': 'perl' \}@" $BASEDIR/vimrc
sed -ie "s@Plug 'davidhalter\/jedi-vim'.*@Plug 'davidhalter\/jedi-vim', \{ 'for': 'python' \}@" $BASEDIR/vimrc
sed -ie "s@Plug 'rust-lang\/rust.vim'.*@Plug 'rust-lang\/rust.vim', \{ 'for': 'rust' \}@" $BASEDIR/vimrc
sed -ie "s@Plug 'racer-rust\/vim-racer'.*@Plug 'racer-rust\/vim-racer', \{ 'for': 'rust' \}@" $BASEDIR/vimrc

