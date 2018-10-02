#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link $BASEDIR ~/.vim
create_dotfile_link ${BASEDIR}/vimrc ~/.vimrc
create_dotfile_link ${BASEDIR}/../nvim/local_init.vim ~/.vimrc.local
create_dotfile_link ${BASEDIR}/../nvim/local_bundles.vim ~/.vimrc.local.bundles

curl -s 'http://vim-bootstrap.com/generate.vim' \
    --data 'langs=javascript&langs=c&langs=html&langs=go&langs=perl&langs=python&langs=rust&editor=vim' \
    > ${BASEDIR}/vimrc

# delete double key mappings
sed -i -e '/noremap <leader>q :bp<CR>/d' $BASEDIR/vimrc
sed -i -e '/noremap <leader>w :bn<CR>/d' $BASEDIR/vimrc

# install requirements
pip3 install --user --upgrade flake8 jedi pylint
# pip2 install --user --upgrade neovim
pip3 install --user --upgrade neovim

# update VIM/NeoVIM
vim --version | grep Compiled > /dev/null
if [ $? -eq 0 ]; then
    vim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
fi

# tuning
sed -i -e "s@Plug 'scrooloose\/nerdtree'.*@Plug 'scrooloose\/nerdtree', \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/vimrc
sed -i -e "s@Plug 'jistr\/vim-nerdtree-tabs'.*@Plug 'jistr\/vim-nerdtree-tabs', \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/vimrc
sed -i -e "s@Plug 'jelera\/vim-javascript-syntax'.*@Plug 'jelera\/vim-javascript-syntax', \{ 'for': [ 'javascript' , 'javascript.jsx' ] \}@" $BASEDIR/vimrc
sed -i -e "s@Plug 'vim-perl\/vim-perl'.*@Plug 'vim-perl\/vim-perl', \{ 'for': 'perl' \}@" $BASEDIR/vimrc
sed -i -e "s@Plug 'c9s\/perlomni.vim'.*@Plug 'c9s\/perlomni.vim', \{ 'for': 'perl' \}@" $BASEDIR/vimrc
sed -i -e "s@Plug 'davidhalter\/jedi-vim'.*@Plug 'davidhalter\/jedi-vim', \{ 'for': 'python' \}@" $BASEDIR/vimrc
sed -i -e "s@Plug 'rust-lang\/rust.vim'.*@Plug 'rust-lang\/rust.vim', \{ 'for': 'rust' \}@" $BASEDIR/vimrc
sed -i -e "s@Plug 'racer-rust\/vim-racer'.*@Plug 'racer-rust\/vim-racer', \{ 'for': 'rust' \}@" $BASEDIR/vimrc

if [ "$OS" == "Windows_NT" ]; then
    sed -i -e "s/'--ansi', //g;s/--ansi //" plugged/fzf.vim/autoload/fzf/vim.vim
    sed -i -e "s/'--header-lines', .*), //g;s/--header-lines=1 //;s/--header-lines[ =]1//" plugged/fzf.vim/autoload/fzf/vim.vim
fi
