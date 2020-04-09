" Function to test OS - return WINDOWS or output of uname
    function! WhichEnv() abort
        if has('win64') || has('win32') || has('win16')
            return 'WINDOWS'
        else
           return toupper(substitute(system('uname'), '\n', '', ''))
        endif
    endfunction

" Determine Plug path depending on VIM type and OS
    let vimconfigpath='~/.vim'
    if (WhichEnv() =~# 'WINDOWS')
        let vimconfigpath=$LOCALAPPDATA . '\\vim'
    endif
    if has("nvim")
        let vimconfigpath='~/.config/nvim'
        if (WhichEnv() =~# 'WINDOWS')
            let vimconfigpath=$LOCALAPPDATA . '\\nvim'
        endif
    endif

" Vim-PLug core - install if not existing
    let vimplug_exists=expand(vimconfigpath . '/autoload/plug.vim')

    if !filereadable(vimplug_exists)
      if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
      endif
      echo "Installing Vim-Plug..."
      echo ""
      silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
      let g:not_finish_vimplug = "yes"

      autocmd VimEnter * PlugInstall
    endif

" Vim-Plug installation
    call plug#begin(expand(vimconfigpath .'/plugged'))
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeToggle' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
    Plug 'Raimondi/delimitMate'
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
    Plug 'w0rp/ale'
    Plug 'Yggdroot/indentLine'
    Plug 'mhinz/vim-startify'
    if executable('sk')
        Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
        Plug 'lotabout/skim.vim'
        " command! -bang -nargs=* Ag call fzf#vim#ag_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
        command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
    else
        if isdirectory('/usr/local/opt/fzf')
          Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
        else
          Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
          Plug 'junegunn/fzf.vim'
        endif
    endif
    let g:make = 'gmake'
    if exists('make')
        let g:make = 'make'
    endif
    Plug 'Shougo/vimproc.vim', {'do': g:make}
    " Vim-Session
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-session'
    " Snippets
    Plug 'SirVer/ultisnips', { 'on': [] }
    Plug 'honza/vim-snippets', { 'on': [] }
    " c/c++
    Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
    Plug 'ludwig/split-manpage.vim'
    " html
    " Plug 'hail2u/vim-css3-syntax'
    " Plug 'gorodinskiy/vim-coloresque'
    Plug 'tpope/vim-haml'
    " Plug 'mattn/emmet-vim'
    " python
    " Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    " Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
    " rust
    Plug 'racer-rust/vim-racer', { 'for': 'rust' }
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'timonv/vim-cargo', { 'for': 'rust' }
    Plug 'vim-scripts/Conque-GDB', { 'for': ['c', 'cpp', 'rust'] }
    " todo:slow Plug 'KabbAmine/zeavim.vim'
    " see colorschemes http://bytefluent.com/vivify/
    Plug 'flazz/vim-colorschemes'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
    " Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'elzr/vim-json', { 'for': 'json' }
    Plug 'ntpeters/vim-better-whitespace'
    " Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
    Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    " todo:slow Plug 'chrisbra/csv.vim'
    Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
    Plug 'joonty/vdebug', { 'for': 'python' }
    " todo:slow Plug 'ap/vim-css-color'
    " syntax for plantuml and make command
    Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
    " generates ASCII (UNICODE) art diagrams- TODO not working in Windows yet
    " Plug 'scrooloose/vim-slumlord', { 'for': 'plantuml' }
    " Plug 'sjurgemeyer/vim-plantuml', { 'for': 'plantuml' }
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
    " Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
    Plug 'vimwiki/vimwiki'
    " Hardmode to learn mode vim
    Plug 'wikitopian/hardmode'
    " Latex
    Plug 'vim-latex/vim-latex', { 'for': 'tex' }
    " todo:fix Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'lervag/vimtex'
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
    Plug 'brooth/far.vim'
    Plug 'justincampbell/vim-eighties'
    " allows opening files at specific location - e.g. /tmp/bal:10:2
    Plug 'wsdjeg/vim-fetch'
    " Plug 'henrik/vim-open-url'
    Plug 'ryanoasis/vim-devicons'
    Plug 'ervandew/supertab'
    Plug 'ycm-core/YouCompleteMe'
    " Emoji support
    Plug 'junegunn/vim-emoji'
    " goyo distraction free mode
    Plug 'junegunn/goyo.vim'
    " Plug 'neomake/neomake'
    " Plug 'CoatiSoftware/vim-sourcetrail'
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

    call plug#end()

" General settings
    " File type settings
    filetype plugin indent on
    " Encoding
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8
    set ttyfast
    " Fix backspace indent
    set backspace=indent,eol,start
    " Tabs. May be overridden by autocmd rules
    set tabstop=4
    set softtabstop=0
    set shiftwidth=4
    set expandtab
    " Map leader to ,
    let mapleader=','
    " Enable hidden buffers
    set hidden
    " File formats
    set fileformats=unix,dos,mac
    " define the SHELL
    if exists('$SHELL')
        set shell=$SHELL
    else
        set shell=/bin/sh
        if (WhichEnv() =~# 'WINDOWS')
            set shell=cmd
        endif
    endif
    " Disable the blinking cursor.
    set gcr=a:blinkon0
    set scrolloff=3
    " Use modeline overrides
    set modeline
    set modelines=10
    " Title
    set title
    set titleold="Terminal"
    set titlestring=%F

" Searching
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase

" session management
    let g:session_directory = vimconfigpath . "/session"
    let g:session_autoload = "no"
    let g:session_autosave = "no"
    let g:session_command_aliases = 1

" Visual Settings
    syntax on
    set ruler
    set number

    let no_buffers_menu=1
    silent! colorscheme molokai

    set mousemodel=popup
    set t_Co=256
    set guioptions=egmrti
    " TODO not working in Windows
    set gfn=Monospace\ 10

    if has("gui_running")
      if has("gui_mac") || has("gui_macvim")
        set guifont=Menlo:h12
        set transparency=7
      endif
    else
      let g:CSApprox_loaded = 1

      " IndentLine
      let g:indentLine_enabled = 1
      let g:indentLine_concealcursor = 0
      let g:indentLine_char = '┆'
      let g:indentLine_faster = 1

    endif

" Statusline
    set laststatus=2
    set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

    if exists("*fugitive#statusline")
      set statusline+=%{fugitive#statusline()}
    endif

" Search mappings:
    " These will make it so that going to the next one in a
    " search will center on the line it's found in.
    nnoremap n nzzzv
    nnoremap N Nzzzv

" vim-airline
    let g:airline_theme = 'powerlineish'
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline_skip_empty_sections = 1

" key mappings
    " no one is really happy until you have this shortcuts
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wq wq
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qall qall

" NERDTree configuration
    let g:NERDTreeChDirMode=2
    let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
    let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
    let g:NERDTreeShowBookmarks=1
    let g:nerdtree_tabs_focus_on_files=1
    let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
    let g:NERDTreeWinSize = 50
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
    nnoremap <silent> <F2> :NERDTreeFind<CR>
    nnoremap <silent> <F3> :NERDTreeToggle<CR>

" terminal emulation
    nnoremap <silent> <leader>sh :terminal<CR>

" Commands
    " remove trailing whitespaces
    command! FixWhitespace :%s/\s\+$//e

" Functions
    if !exists('*s:setupWrapping')
      function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
      endfunction
    endif

    " Autocmd Rules
    " The PC is fast enough, do syntax highlight syncing from start unless 200 lines
    augroup vimrc-sync-fromstart
      autocmd!
      autocmd BufEnter * :syntax sync maxlines=2000
    augroup END

    " Remember cursor position
    augroup vimrc-remember-cursor-position
      autocmd!
      autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END

    " txt
    augroup vimrc-wrapping
      autocmd!
      autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
    augroup END

    " make/cmake
    augroup vimrc-make-cmake
      autocmd!
      autocmd FileType make setlocal noexpandtab
      autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
    augroup END

    set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
" noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --no-ignore --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ale
    let g:ale_linters = {
    \   'ansible': ['ansible_lint'],
    \   'asciidoc': ['textlint', 'writegood'],
    \   'asm': ['cpp'],
    \   'awk': ['gawk'],
    \   'bib': ['bibclean'],
    \   'c': ['clang', 'clangtidy', 'cppcheck', 'flawfinder', 'gcc'],
    \   'chef': ['cookstyle', 'foodcritic'],
    \   'cmake': ['cmakelint'],
    \   'cpp': ['clang', 'clangcheck', 'clangtidy', 'cppcheck', 'cpplint', 'flawfinder', 'gcc'],
    \   'css': ['csslint', 'fecs', 'stylelint'],
    \   'cucumber': ['cucumber'],
    \   'dockerfile': ['dockerfile_lint', 'hadolint'],
    \   'gitcommit': ['gitlint'],
    \   'go': ['gobuilt', 'gofmt', 'golint', 'langserver', 'staticcheck'],
    \   'help': ['proselint', 'writegood'],
    \   'html': ['fecs', 'htmllint', 'proselint', 'stylelint', 'tidy', 'writegood'],
    \   'java': ['checkstyle', 'javac'],
    \   'javascript': ['eslint', 'fecs', 'jshint', 'tsserver', 'xo'],
    \   'json': ['jsonlint'],
    \   'kotlin': ['kotlinc', 'ktlint', 'languageserver'],
    \   'less': ['stylelint'],
    \   'lua': ['luac', 'luacheck'],
    \   'make': ['checkmake'],
    \   'markdown': ['languagetool', 'markdownlint', 'proselint', 'textlint', 'writegood'],
    \   'matlab': ['mlint'],
    \   'proto': ['proto_gen_lint'],
    \   'python': ['bandit', 'flake8', 'mypy', 'vulture', 'pycodestyle','pydocstyle'],
    \   'rust': ['cargo', 'rls', 'rustc'],
    \   'sh': ['shellcheck', 'shell', 'language_server'],
    \   'sql': ['sqlint'],
    \   'tex': ['chktex', 'lacheck', 'proselint', 'texlab', 'texlint', 'writegood'],
    \   'texinfo': ['proselint', 'writegood'],
    \   'text': ['languagetool', 'proselint', 'textlint', 'writegood'],
    \   'typescript': ['eslint', 'tslint', 'typecheck', 'tsserver', 'xo'],
    \   'vim': ['vint', 'ale_custom_linting_rules'],
    \   'xhtml': ['proselint', 'writegood'],
    \   'xml': ['xmllint'],
    \   'yaml': ['swaglint', 'yamllint'],
    \   'yang': ['yang_lsp'],
    \}
    "   'python': ['bandit', 'flake8', 'mypy', 'pycodestyle', 'pylint', 'pydocstyle'],
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'css': ['prettier'],
    \   'go': ['gofmt', 'goimports'],
    \   'html': ['prettier'],
    \   'javascript': ['prettier', 'eslint'],
    \   'less': ['prettier'],
    \   'python': ['black'],
    \   'rust': ['rustfmt'],
    \   'sh': ['shfmt'],
    \   'sql': ['sqlfmt'],
    \   'tex': ['latexindent'],
    \   'yaml': ['prettier'],
    \}
    " 'python': ['black', 'isort', 'docformatter', 'pyment'],
    let g:ale_linters_explicit = 1
    let g:ale_fix_on_save = 1
    let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
    " vim ale
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 1
    let g:ale_completion_enabled = 1
    " let g:ale_fixers = {
    " \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    " \   'javascript': ['eslint'],
    " \}
    let g:ale_fix_on_save = 1
    let g:airline#extensions#ale#enabled = 1
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_open_list = 1


" Tagbar
" TODO better use <leader>T or something else
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut - Share the VIM clipboard with the X11 clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" TODO: what is this for??? <01-03-20, Heiko Riemer> "
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab


" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let python_highlight_all = 1

" rust
" Vim racer
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" MyConf
let g:snips_author = "Heiko Riemer"
let g:session_autosave = 'no'

" let g:python3_host_prog = '/cygdrive/c/Users/pt103371/AppData/Local/Programs/Python/Python36'
" let g:python3_host_prog = '/usr/bin/python3'

" Jedi (python) {{{
    let g:jedi#popup_on_dot = 1
    let g:jedi#smart_auto_mappings = 1
    let g:jedi#goto_definitions_command = '<leader>d'
    let g:jedi#show_call_signatures = 1
" }}}

" Font settings {{{
" set gfn=Monospace\ 8
" set gfn=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
" set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline\ 10
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set guifont=Hack:h10
" }}}

set nocompatible
set noinsertmode    " do not start vim in insert mode
set backup " tell vim to keep a backup file
set backupdir=~/vimfiles/backup " tell vim where to put its backup files
set dir=~/vimfiles/swap " tell vim where to put swap files
set encoding=UTF-8

" some settings regarding ctags
set tags=tags,.git/tags,.svn/tags,../tags,../.git/tags,../.svn/tags,../../tags,../../.git/tags,../../.svn/tags,../../../tags,../../../.git/tags,../../../.svn/tags;

" Spaces Tabs:
    " Info: already in .vimrc
    " syntax enable           " enable syntax processing
    " Info: disabled, since already call in .vimrc and very slow
    " filetype plugin indent on
    set tabstop=4       " number of visual spaces per TAB
    set softtabstop=4   " number of spaces in tab when editing
    set shiftwidth=4    " when indenting with '>', use 4 spaces width
    set expandtab       " tabs are spaces

" UI Config:
    set number              " show line numbers
    set relativenumber      " show relative line numbers above and below current line
    set showcmd             " show command in bottom bar
    set cursorline          " highlight current line
    " Info: disabled, since already call in .vimrc and very slow
    " filetype indent on      " load filetype-specific indent files
    set wildmenu            " visual autocomplete for command menu
    set lazyredraw          " redraw only when we need to.
    set showmatch           " highlight matching [{()}]

" YouCompleteMe:
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

" Snipplets:
    let g:UltiSnipsSnippetsDir="~/dotfiles/vim/UltiSnips"
    let g:UltiSnipsListSnippets="<s-tab>"
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" PlantUML Syntax:
    au BufNewFile,BufRead *.uml set filetype=plantuml

" Key Mappings:
    " jump between buffers in normal mode
    nnoremap <c-h> <c-w>h
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-l> <c-w>l
    " jump between buffers in visual mode
    xnoremap <c-h> <c-w>h
    xnoremap <c-j> <c-w>j
    xnoremap <c-k> <c-w>k
    xnoremap <c-l> <c-w>l
    " remove ^M from dos files
    nnoremap <leader>m :e ++ff=dos<cr>

" Searching:
    set incsearch           " search as characters are entered
    set hlsearch            " highlight matches
    " turn off search highlight
    " nnoremap <leader><space> :nohlsearch<CR>
    set   ignorecase        " search ifnoring the case
    set   magic
    " all special characters are interpreted (requires masking
    nnoremap / /\v
    vnoremap / /\v

" Folding:
    set foldenable          " enable folding
    set foldlevel=99
    set foldlevelstart=0   " open most folds by default
    set foldnestmax=10      " 10 nested fold max
    " space open/closes folds
    nnoremap <space> za
    set foldmethod=indent   " fold based on indent level
    " set foldmethod=marker
    " set foldlevel=0
    nnoremap <F2> zR
    nnoremap <F3> zM

" Movement:
    " move vertically by visual line
    nnoremap j gj
    nnoremap k gk
    " move to beginning/end of line
    nnoremap B ^
    nnoremap E $
    " " $/^ doesn't do anything
    " nnoremap $ <nop>
    " nnoremap ^ <nop>
    " highlight last inserted text
    nnoremap gV `[v`]

" TMux:
    " allows cursor change in tmux mode
    " if exists('$TMUX')
    "     let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    "     let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    " else
    "     let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    "     let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    " endif


" Autogroups:
    augroup configgroup
        autocmd!
        autocmd VimEnter * highlight clear SignColumn
        " autocmd BufWritePre *.py
        "             \:call <SID>StripWhitespaces()
        " " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
        "             \:call <SID>StripTrailingWhitespaces()
        autocmd FileType java setlocal noexpandtab
        autocmd FileType java setlocal list
        autocmd FileType java setlocal listchars=tab:+\ ,eol:-
        autocmd FileType java setlocal formatprg=par\ -w80\ -T4
        autocmd FileType php setlocal expandtab
        autocmd FileType php setlocal list
        autocmd FileType php setlocal listchars=tab:+\ ,eol:-
        autocmd FileType php setlocal formatprg=par\ -w80\ -T4
        autocmd FileType ruby setlocal tabstop=2
        autocmd FileType ruby setlocal shiftwidth=2
        autocmd FileType ruby setlocal softtabstop=2
        autocmd FileType ruby setlocal commentstring=#\ %s
        autocmd FileType python setlocal commentstring=#\ %s
        autocmd BufEnter *.cls setlocal filetype=java
        autocmd BufEnter *.zsh-theme setlocal filetype=zsh
        autocmd BufEnter Makefile setlocal noexpandtab
        autocmd BufEnter *.sh setlocal tabstop=4
        autocmd BufEnter *.sh setlocal shiftwidth=4
        autocmd BufEnter *.sh setlocal softtabstop=4
        autocmd BufEnter *.uml,*.plantuml,*.puml setlocal nofoldenable
    augroup END

" Functions:
    " toggle between number and relativenumber
    function! ToggleNumber()
        if(&relativenumber == 1)
            set norelativenumber
            set number
        else
            set relativenumber
        endif
    endfunc

" Plugin Settings:
    " Syntastic
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1

    " let g:syntastic_python_checkers = ['pylint', 'flake8']
    let g:syntastic_python_checkers = ['pylint']
    " let g:syntastic_python_flake8_args='--ignore=E501,E225'
    let g:syntastic_python_flake8_args='--max-line-length=120'
    let g:syntastic_python_pylint_post_args="--max-line-length=120"
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_always_populate_loc_list = 1

    " let g:syntastic_java_javac_config_file_enabled = 0
    let g:loaded_syntastic_java_javac_checker = 1

    " Markdown
    " let g:vim_markdown_folding_style_pythonic = 1
    let g:vim_markdown_new_list_item_indent = 2
    let g:vim_markdown_folding_disabled = 0
    let g:vim_markdown_toc_autofit = 1
    let g:vim_markdown_json_frontmatter = 0
    let g:vim_markdown_new_list_item_indent = 2
    let g:vim_markdown_autowrite = 1
    " let g:vim_markdown_auto_extension_ext = 'md'
    let g:markdown_minlines = 1000
    let g:markdown_syntax_conceal = 0

    " Indent guides
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 1
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red ctermbg=3
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

    " NerdTree
    " Use <-C-n> as shortcut
    map <C-n> :NERDTreeToggle<CR>
    " Start automatically if no file is opened
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " Close vim if only Nerdtree is open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " custom arrows
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'

    " NerdTree-git-plugin
    let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
     " show ignore files - heavy on performance
     let g:NERDTreeShowIgnoredStatus = 1

    " Rust.vim
    let g:rustfmt_autosave = 1
    let g:rust_clip_command = 'xclip -selection clipboard'

    " vim-better-whitespace
    " let g:better_whitespace_verbosity=1
    autocmd FileType *.py,*.sh,*.rs autocmd BufEnter <buffer> EnableStripWhitespaceOnSave

    " Plantuml-syntax
    " TODO: (pt103371) - make this work in Windows
    let g:slumlord_plantuml_jar_path = 'c:\\Data\\pt103371\\bin\\plantuml.jar'
    let g:plantuml_executable_script = "~/bin/plantUML.sh"
    " if has('windows')
    "     let g:plantuml_executable_script = 'c:\\Data\\pt103371\\bin\\plantUML.sh'
    " endif

    " sjurgemeyer/vim-plantuml
    " let g:plantuml_jar_path = "~/bin/plantuml.jar"
    " if has('windows')
    "     let g:plantuml_jar_path = 'c:\\Data\\pt103371\\bin\\plantuml.jar'
    " endif
    noremap <leader>V :silent! !tmux split-window "/usr/bin/env zsh -c \"tmux resize-pane -y 3;source $HOME/.zshrc; cd $HOME/PlantUML; ls *.uml \| entr -p ~/bin/plantUML.sh /_\""<CR>

" go.vim
    " do not show warning for older releases
    let g:go_version_warning = 0

" Colorscheme:
    " Molokai
    " Info: already set in .vimrc
    " colorscheme molokai
    " let g:molokai_original = 1
    " let g:rehash256 = 1

    " good ones: molokai, darkZ, desertEx, jellybeans,
    " no_quarter
    " colorscheme jellybeans
    " let g:airline_theme='jellybeans'
    " colorscheme molokai
    let g:airline_theme='molokai'

    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    if has("termguicolors")
        set termguicolors
    endif

    " Gundo
    nnoremap <F8> :GundoToggle<CR>

" Vimdiff
    set diffopt+=iwhite
    set diffexpr=""
    " set scrollbind
    if &diff
        set cursorline
        map ] ]c
        map [ [c
        " hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
        " hi DiffChange ctermbg=Darkblue  guibg=#ececec gui=none   cterm=none
        " hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
    endif

""" fzf.vim
    set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.jar,*.png,*.class,*.jpg,*.pdf,*.pst,*.ppt,*.doc,*.xls,*.pptx,*.docx,*.xlsx,*.ico,*.bmp,*.gif,*.7z,*.deb,*.rpm,*.dot,*.exe,*.dll,*.aps,*.chm,*.dat,*.dump,*.mp3,*.mkv,*.mp4,*.m4a,*.gz,*.tar,*.tgz,*.mdb,*.msg,*.odt,*.oft,*.pdb,*.ppm,*.pps,*.pub,*.mobi,*.rtf,*.stackdump,*.dump,*.ttf,*.otf,*.tmp,*.temp,*.zip
    " let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'bin/**' -prune -o -path '.cache/**' -prune -o -path 'cache/**' -prune -o -path '$Recycle.bin/**' -prune -o -path 'vim/bundle/**' -prune -o -path '__pycache__/**' -prune -o -path '.cache/**' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

    " The Silver Searcher
    " if executable('ag')
    "     " let $FZF_DEFAULT_COMMAND = 'ag --hidden --smart-case -0 --silent --width 140 --color --follow --one-device --search-zip --ignore .git -g ""'
    "     let $FZF_DEFAULT_COMMAND = 'ag --hidden --smart-case --silent --follow --one-device --search-zip --ignore .git -g ""'
    "     set grepprg=ag\ --nogroup\ --nocolor
    " endif

    " " ripgrep
    " if executable('rg')
    "   " let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    "   let $FZF_DEFAULT_COMMAND ='rg --files --hidden --follow -g ''!.git/'''
    "   set grepprg=rg\ --vimgrep
    "   command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
    " endif

    " --column: Show column number
    " --line-number: Show line number
    " --no-heading: Do not show file headings in results
    " --fixed-strings: Search term as a literal string
    " --ignore-case: Case insensitive search
    " --no-ignore: Do not respect .gitignore, etc...
    " --hidden: Search hidden files and folders
    " --follow: Follow symlinks
    " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
    " --color: Search color options
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

    " This is the default extra key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    let g:fzf_layout = { 'down': '~40%' }

    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
                \ { 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'] }

    " Enable per-command history.
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = '~/.local/share/fzf-history'
    nnoremap <Leader>f :GFiles<CR>
    nnoremap <Leader>F :Files<CR>
    nnoremap <Leader>b :Buffers<CR>
    nnoremap <Leader>y :History<CR>
    nnoremap <Leader>t :BTags<CR>
    nnoremap <Leader>T :Tags<CR>
    nnoremap <Leader>l :BLines<CR>
    nnoremap <Leader>L :Lines<CR>
    nnoremap <Leader>' :Marks<CR>
    nnoremap <Leader>a :Rg<Space><CR>
    nnoremap <Leader>H :Helptags!<CR>
    nnoremap <Leader>C :Commands<CR>
    nnoremap <Leader>: :History:<CR>
    nnoremap <Leader>/ :History/<CR>
    nnoremap <Leader>M :Maps<CR>
    nnoremap <Leader>s :Filetypes<CR>

""" vim-slumlord
    let g:slumlord_plantuml_jar_path = '~/bin/plantuml.jar'
    " if has('win32')
    "     let g:slumlord_plantuml_jar_path = 'c:\Data\pt103371\bin\plantuml.jar'
    " endif

""" vimwiki
    " vimwiki with markdown support
    let wiki_1 = {}
    let wiki_1.path = '~/vimwiki/work/'
    let wiki_1.syntax = 'markdown'
    let wiki_1.ext = '.md'

    let wiki_2 = {}
    let wiki_2.path = '~/vimwiki/personal/'
    let wiki_2.syntax = 'markdown'
    let wiki_2.ext = '.md'

    let g:vimwiki_list = [wiki_1, wiki_2]
    let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    " helppage -> :h vimwiki-syntax
    let g:vimwiki_table_mappings = 0
    let g:vimwiki_global_ext = 0
    let g:vimwiki_folding='expr'
    let g:vimwiki_table_auto_fmt=1
    " au FileType vimwiki set syntax=markdown

" start a pomodoro timer
    noremap <leader>T :silent !tmux split-window "/usr/bin/env zsh -c \"tmux resize-pane -y 3;source ~/.zshrc; cd ~/opt; gtd\""<CR>

""" misc
    " nnoremap <leader>H <Esc>:call ToggleHardMode()<CR>
    let g:HardMode_level = 'wannabe'
    " let g:HardMode_hardmodeMsg = 'Don't use this!'
    autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Misc:
    " visualize whitespaces
    set list
    set listchars=nbsp:¬,tab:»·,trail:·
    " Breaking lines with \[enter] without having to go to insert mode (myself).
    nmap <leader><cr> i\<cr><Esc>
    " Reload changes to .vimrc automatically
    autocmd BufWritePost ~/.vimrc source ~/.vimrc
    " Show a max line indicator
    set colorcolumn=100
    " find long lines
    " TODO: find better shortcut <17-09-18, Heiko Riemer> "
    " map <F9> /\%>100v.\+
    " Update term title but restore old title after leaving Vim
    set title
    set titleold=
    set path+=**

" splits:
    set splitbelow
    set splitright

" vim-open-url
    " let g:open_url_browser="xdg-open"
    let g:open_url_browser="firefox"
    function! HandleURL()
        let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;\(\)]*')
        echo s:uri
        if s:uri != ""
            " silent exec "!open '".s:uri."'"
            silent exec "!firefox '".s:uri."' &"
            redraw!
        else
            echo "No URI found in line."
        endif
    endfunction
    map <leader>u :call HandleURL()<cr>

" clipboard:
    " set clipboard=unnamedplus
    " if has('win32')
    "     set clipboard=unnamed
    " endif
    "
    set tags=ctags,.git/ctags,.svn/ctags,../ctags,../.git/ctags,../.svn/ctags,../../ctags,../../.git/ctags,../../.svn/ctags,../../../ctags,../../../.git/ctags,../../../.svn/ctags;

" neomake:
    " When writing a buffer (no delay).
    " call neomake#configure#automake('w')
    " When writing a buffer (no delay), and on normal mode changes (after 750ms).
    " call neomake#configure#automake('nw', 750)
    " When reading a buffer (after 1s), and when writing (no delay).
    " call neomake#configure#automake('rw', 1000)
    " Full config: when writing or reading a buffer, and on changes in insert and
    " normal mode (after 1s; no delay when writing).
    " call neomake#configure#automake('nrwi', 500)
    " let g:neomake_open_list = 2

" Spelling:
    set spelllang=en_us
    set spell!

" vim-auto-save:
    " autocmd FileType vimwiki setlocal let g:auto_save = 1  " enable AutoSave on Vim startup
    " autocmd FileType markdown setlocal let g:auto_save = 1  " enable AutoSave on Vim startup
    let g:auto_save = 0  " enable AutoSave on Vim startup
    " let g:auto_save_events = ["InsertLeave", "TextChanged"] " only save when leaving insert mode or changing things
    let g:auto_save_write_all_buffers = 0  " write all open buffers as if you would use :wa
    " let g:auto_save_no_updatetime = 0  " do not change the 'updatetime' option
    let g:updatetime = 5000  "global updatetime set to 5sec
    let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
    " let g:auto_save_silent = 1  " do not display the auto-save notification

    " let g:auto_save_presave_hook = 'call AbortIfNotMD()'
    " function! AbortIfNotMD()
    "   if &filetype != 'markdown'
    "     let g:auto_save_abort = 1
    "   endif
    " endfunction

" eighties.vim:
    let g:eighties_enabled = 1
    let g:eighties_minimum_width = 80
    let g:eighties_extra_width = 20 " Increase this if you want some extra room
    let g:eighties_compute = 1 " Disable this if you just want the minimum + extra
    let g:eighties_bufname_additional_patterns = ['fugitiveblame'] " Defaults to [], 'fugitiveblame' is only an example. Takes a comma delimited list of bufnames as strings.

" Floating Terminals - like LazyGit or LazyDocker
    " Creates a floating window with a most recent buffer to be used
    if has('nvim')
        function! CreateCenteredFloatingWindow()
            let width = float2nr(&columns * 0.9)
            let height = float2nr(&lines * 0.9)
            let top = ((&lines - height) / 2) - 1
            let left = (&columns - width) / 2
            let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
            let top = "╭" . repeat("─", width - 2) . "╮"
            let mid = "│" . repeat(" ", width - 2) . "│"
            let bot = "╰" . repeat("─", width - 2) . "╯"
            let lines = [top] + repeat([mid], height - 2) + [bot]
            let s:buf = nvim_create_buf(v:false, v:true)
            call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
            call nvim_open_win(s:buf, v:true, opts)
            set winhl=Normal:Floating
            let opts.row += 1
            let opts.height -= 2
            let opts.col += 2
            let opts.width -= 4
            call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
            autocmd BufWipeout <buffer> exe 'bwipeout '.s:buf
        endfunction
        " When term starts, auto go into insert mode
        autocmd TermOpen * startinsert
        " Turn off line numbers etc
        autocmd TermOpen * setlocal listchars= nonumber norelativenumber

        " function to toggle the window
        function! ToggleTerm(cmd)
            if empty(bufname(a:cmd))
                call CreateCenteredFloatingWindow()
                call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
            else
                bwipeout!
            endif
        endfunction

        function! OnTermExit(job_id, code, event) dict
            if a:code == 0
                bwipeout!
            endif
        endfunction

        nnoremap <silent> <Leader>lg :call ToggleTerm('lazygit')<CR>
        nnoremap <silent> <Leader>ld :call ToggleTerm('lazydocker')<CR>
    endif

" vim-airline
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    if !exists('g:airline_powerline_fonts')
      let g:airline#extensions#tabline#left_sep = ' '
      let g:airline#extensions#tabline#left_alt_sep = '|'
      let g:airline_left_sep          = '▶'
      let g:airline_left_alt_sep      = '»'
      let g:airline_right_sep         = '◀'
      let g:airline_right_alt_sep     = '«'
      let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
      let g:airline#extensions#readonly#symbol   = '⊘'
      let g:airline#extensions#linecolumn#prefix = '¶'
      let g:airline#extensions#paste#symbol      = 'ρ'
      let g:airline_symbols.linenr    = '␊'
      let g:airline_symbols.branch    = '⎇'
      let g:airline_symbols.paste     = 'ρ'
      let g:airline_symbols.paste     = 'Þ'
      let g:airline_symbols.paste     = '∥'
      let g:airline_symbols.whitespace = 'Ξ'
    else
      let g:airline#extensions#tabline#left_sep = ''
      let g:airline#extensions#tabline#left_alt_sep = ''

      " powerline symbols
      let g:airline_left_sep = ''
      let g:airline_left_alt_sep = ''
      let g:airline_right_sep = ''
      let g:airline_right_alt_sep = ''
      let g:airline_symbols.branch = ''
      let g:airline_symbols.readonly = ''
      let g:airline_symbols.linenr = ''
    endif

" Conque GDB (RUST/C/CPP debugging)
    let g:ConqueTerm_StartMessages = 0
    let g:ConqueTerm_Color = 0
    let g:ConqueTerm_CloseOnEnd = 1
    let g:ConqueTerm_Interrupt = '<C-g><C-c>'
    let g:ConqueTerm_ReadUnfocused = 1

" comments in italic
    " highlight Comment gui=italic
