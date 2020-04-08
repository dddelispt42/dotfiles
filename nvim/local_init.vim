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
    " allow use of page up and down keys
    map <PageUp>   <C-B>
    map <PageDown> <C-F>
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
    " nnoremap <leader>t <Esc>:tabnew<CR>

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
    " Fugitive
    " set statusline+=%{fugitive#statusline()}

    " CtrlP settings
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    " let g:ctrlp_match_window = 'bottom,order:ttb'
    " let g:ctrlp_switch_buffer = 0
    " let g:ctrlp_working_path_mode = 0
    " let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    let g:ctrlp_working_path_mode = 'ra'
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    " let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
    " let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
    " let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
    " let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    " let g:ctrlp_user_command = ['.hg', 'hg --cwd %s locate -I .']
    " let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'  " Use ripgrep
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'find %s -type f'
    \ }
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    if executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor --skip-vcs-ignores -g ""'
    endif

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

    " TODO Ployglot is very slow
    " let g:polyglot_disabled = ['python', 'markdown', 'java']

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

    " " should markdown preview get shown automatically upon opening markdown buffer
    " let g:livedown_autorun = 0
    " " should the browser window pop-up upon previewing
    " let g:livedown_open = 0
    " " the port on which Livedown server will run
    " let g:livedown_port = 1337
    " " the browser to use
    " let g:livedown_browser = "C:\Data\pt103371\bin\apps\PortableApps\FirefoxPortable\App\Firefox\firefox.exe"

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

    " ack.vim
    if executable('ag')
        let g:ackprg = 'ag --vimgrep'
    endif
    cnoreabbrev Ack Ack!
    " open ack in new tab
    " nnoremap <Leader>a :tab split<cr>:Ack! ""<left>
    " open ack in new tab
    " nnoremap <Leader>A :tab split<cr>:Ack! <c-r><c-w><cr>

    " Zeavim
    " let g:zv_zeal_executable = has('win32')
    "         \ ? 'c:\Data\pt103371\bin\zeal-portable-0.5.0-windows-x64\zeal.exe'
    "         \ : 'zeal'
    " let g:zv_zeal_executable = zeal.exe
    let g:zv_file_types = {
                \   'scss'                     : 'sass',
                \   'sh'                       : 'bash',
                \   'tex'                      : 'latex',
                \   'css'                      : 'css,foundation',
                \   '.htaccess'                : 'apache_http_server',
                \   '\v^(G|g)runt\.'           : 'gulp,javascript,nodejs',
                \   '\v^(G|g)ulpfile\.'        : 'grunt',
                \   '\v^(md|mdown|mkd|mkdn)$'  : 'markdown',
                \   'py'  : 'python3',
                \   'rs'  : 'rust'
                \ }

    " vim-javacomplete2
    " autocmd FileType java setlocal omnifunc=javacomplete#Complete
    " nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    " imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    " nmap <F5> <Plug>(JavaComplete-Imports-Add)
    " imap <F5> <Plug>(JavaComplete-Imports-Add)
    " nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    " imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    " nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    " imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

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

" lazygit.vim
    if filereadable(expand("~/dotfiles/nvim/lazygit.vim"))
      source ~/dotfiles/nvim/lazygit.vim
    endif
    nnoremap <silent> <Leader>lg :call ToggleLazyGit()<CR>
