" todo:slow Plug 'KabbAmine/zeavim.vim'
" see colorschemes http://bytefluent.com/vivify/
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" Plug 'kien/ctrlp.vim'
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'ntpeters/vim-better-whitespace'
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
" todo:slow Plug 'chrisbra/csv.vim'
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
" todo:slow Plug 'ap/vim-css-color'
" syntax for plantuml and make command
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
" generates ASCII (UNICODE) art diagrams- TODO not working in Windows yet
" todo:fix Plug 'scrooloose/vim-slumlord', { 'for': 'plantuml' }
Plug 'nathanalderson/yang.vim', { 'for': 'yang' }
" todo:slow Plug 'bling/vim-bufferline'
" interesting but not yet configured
Plug 'sjl/gundo.vim', { 'on': [] }
" interesting but not yet configured
Plug 'mileszs/ack.vim'
" todo:slow Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
" Git commit browser (:GV)
Plug 'junegunn/gv.vim'
" works with tabular to format markdown tables when pressing "|"
" todo: fix Plug 'quentindecock/vim-cucumber-align-pipes'
" immediate preview
" Vimwiki - http://thedarnedestthing.com/vimwiki%20cheatsheet
Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
" Hardmode to learn mode vim
Plug 'wikitopian/hardmode'
" Latex
Plug 'vim-latex/vim-latex', { 'for': 'tex' }
" todo:fix Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'benmills/vimux'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/matchit.zip'
" Plug 'rstacruz/sparkup'
" Plug 'mjbrownie/hackertyper.vim'
" Plug 'sirtaj/vim-openscad'
Plug '907th/vim-auto-save'
" Plug 'will133/vim-dirdiff'
" Plug 'joonty/vim-do'
Plug 'christoomey/vim-conflicted'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'w0rp/ale'
Plug 'brooth/far.vim'

" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'ervandew/supertab'

" let g:deoplete#enable_at_startup = 1

" Plugins loaded when entering insert mode
augroup load_us_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('gundo.vim', 'ultisnips', 'vim-snippets')
                     \| autocmd! load_us_ycm
augroup END

" Plugins to disable:
"
" Insert mode - bootstrap
" Raimondi/delimitMate
" SirVer/ultisnips
" honza/vim-snippets
"
" tagbar on toggle
"
" Switch
" polyglot and syntasitc to vim-ale
"
" Further speed up:
" - do not check for executable - do it during bootstrap e.g. ag, ack, rg, ...
