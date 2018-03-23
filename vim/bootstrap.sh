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
sed -i '/noremap <leader>z :bp<CR>/d' $BASEDIR/vimrc
sed -i '/noremap <leader>x :bn<CR>/d' $BASEDIR/vimrc

# sudo apt-get install git exuberant-ctags ncurses-term curl

# install requirements
pip3 install flake8 jedi pylint
# pip2 install --user --upgrade neovim
pip3 install --user --upgrade neovim

# TODO: (pt103371) - does not work w/o terminal
# vim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +qall

# TODO: (heiko) - check if plantuml.jar is in bin and create plantuml.sh
