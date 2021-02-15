vim.g.mapleader = ","

require('general')
require('plugins')
require('utils')
require('lsp')

--[[
set tabstop=4
set softtabstop=4
set shiftwidth=4
set hidden
set scrolloff=3
set spell!
set smartcase
set inccommand=nosplit
set number
set relativenumber
set cursorline
set showmatch
set termguicolors
set colorcolumn=100
set path+=**
set splitbelow
set splitright
set tags=ctags,.git/ctags,.svn/ctags,../ctags,../.git/ctags,../.svn/ctags,../../ctags,../../.git/ctags,../../.svn/ctags,../../../ctags,../../../.git/ctags,../../../.svn/ctags;
set list
set listchars=nbsp:¬,tab:»·,trail:·
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.jar,*.png,*.class,*.jpg,*.pdf,*.pst,*.ppt,*.doc,*.xls,*.pptx,*.docx,*.xlsx,*.ico,*.bmp,*.gif,*.7z,*.deb,*.rpm,*.dot,*.exe,*.dll,*.aps,*.chm,*.dat,*.dump,*.mp3,*.mkv,*.mp4 ,*.m4a,*.gz,*.tar,*.tgz,*.mdb,*.msg,*.odt,*.oft,*.pdb,*.ppm,*.pps,*.pub,*.mobi,*.rtf,*.stackdump,*.dump,*.ttf,*.otf,*.tmp,*.temp,*.zip
set textwidth=119
set dir=~/.cache/vim/swap
set tags=tags,.git/tags,.svn/tags,../tags,../.git/tags,../.svn/tags,../../tags,../../.git/tags,../../.svn/tags,../../../tags,../../../.git/tags,../../../.svn/tags;
TODO: setstatusline with fugitive
TODO: clipboard
]]
