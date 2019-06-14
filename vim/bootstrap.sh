#!/bin/bash
BASEDIR=$(dirname $(realpath "$0"))
source ../dotfile_functions.sh

create_dotfile_link $BASEDIR ~/.vim
create_dotfile_link ${BASEDIR}/vimrc ~/.vimrc
create_dotfile_link ${BASEDIR}/../nvim/local_init.vim ~/.vimrc.local
create_dotfile_link ${BASEDIR}/../nvim/local_bundles.vim ~/.vimrc.local.bundles

# curl -s 'http://vim-bootstrap.com/generate.vim' \
#     --data 'langs=javascript&langs=c&langs=html&langs=go&langs=perl&langs=python&langs=rust&editor=vim' \
#     > ${BASEDIR}/vimrc
curl -s 'http://vim-bootstrap.com/generate.vim' \
    --data 'langs=c&langs=html&langs=python&langs=rust&editor=vim' \
    > ${BASEDIR}/vimrc

# delete double key mappings
sed -i -e '/noremap <leader>q :bp<CR>/d' $BASEDIR/vimrc
sed -i -e '/noremap <leader>w :bn<CR>/d' $BASEDIR/vimrc

# I want backup and swapfiles
sed -i -e 's/set nobackup/set backup/' $BASEDIR/vimrc
sed -i -e 's/set noswapfile/set swapfile/' $BASEDIR/vimrc

# install requirements
# pip3 install --user --upgrade flake8 jedi pylint
# pip2 install --user --upgrade neovim
# pip3 install --user --upgrade neovim

# tuning
sed -i -e "s@\(Plug 'scrooloose\/nerdtree'.*\)@\1, \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'jistr\/vim-nerdtree-tabs'.*\)@\1, \{ 'on': 'NERDTreeToggle' \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'majutsushi\/tagbar'.*\)@\1, \{ 'on': 'TagbarToggle' \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'jelera\/vim-javascript-syntax'.*\)@\1, \{ 'for': [ 'javascript' , 'javascript.jsx' ] \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'vim-perl\/vim-perl'.*\)@\1, \{ 'for': 'perl' \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'c9s\/perlomni.vim'.*\)@\1, \{ 'for': 'perl' \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'davidhalter\/jedi-vim'.*\)@\1, \{ 'for': 'python' \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'rust-lang\/rust.vim'.*\)@\1, \{ 'for': 'rust' \}@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'racer-rust\/vim-racer'.*\)@\1, \{ 'for': 'rust' \}@" $BASEDIR/vimrc
# activate upon insert only
sed -i -e "s@\(.*Plug 'SirVer\/ultisnips'.*\)@\1, \{ 'on': [] \}@" $BASEDIR/vimrc
sed -i -e "s@\(.*Plug 'honza\/vim-snippets'.*\)@\1, \{ 'on': [] \}@" $BASEDIR/vimrc
# disabling
sed -i -e "s@\(Plug 'hail2u\/vim-css3-syntax'.*\)@\" \1@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'vim-scripts\/grep.vim'.*\)@\" \1@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'vim-scripts\/CSApprox'.*\)@\" \1@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'mattn\/emmet-vim'.*\)@\" \1@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'sheerun\/vim-polyglot'.*\)@\" \1@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'gorodinskiy\/vim-coloresque'.*\)@\" \1@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'avelino\/vim-bootstrap-updater'.*\)@\" \1@" $BASEDIR/vimrc
sed -i -e "s@\(Plug 'tomasr\/molokai'.*\)@\" \1@" $BASEDIR/vimrc

if [ "$OS" = "Windows_NT" ]; then
    sed -i -e "s/'--ansi', //g;s/--ansi //" plugged/fzf.vim/autoload/fzf/vim.vim
    sed -i -e "s/'--header-lines', .*), //g;s/--header-lines=1 //;s/--header-lines[ =]1//" plugged/fzf.vim/autoload/fzf/vim.vim
fi

# update VIM/NeoVIM
vim --version | grep Compiled > /dev/null
if [ $? -eq 0 ]; then
    # vim +VimBootstrapUpdate +PlugInstall +PlugUpgrade +PlugUpdate +PlugClean +qall
    vim +PlugInstall +PlugUpdate +PlugClean +qall
fi

