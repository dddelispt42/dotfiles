local o = vim.o
local wo = vim.wo
local bo = vim.bo

o.swapfile = true
if vim.loop.os_uname().sysname:find("Windows", 1, true) and true then
	o.dir = os.getenv("LOCALAPPDATA") .. "\\vim\\swap"
else
	o.dir = os.getenv("XDG_CACHE_HOME") .. "/vim/swap"
end

o.backup = false -- creates a backup file
o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.cmdheight = 2 -- more space in the neovim command line for displaying messages
o.completeopt = "menuone,noinsert,noselect,preview" -- mostly just for cmp
o.conceallevel = 0 -- so that `` is visible in markdown files
o.cursorline = true -- highlight the current line
o.expandtab = true -- convert tabs to spaces
o.fileencoding = "utf-8" -- the encoding written to a file
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.foldnestmax = 10
o.formatoptions = "jroql"
-- o.guifont = "monospace:h17" -- the font used in graphical neovim applications
o.guifont = "Hack NF:h10" -- the font used in graphical neovim applications
o.hidden = true
o.hlsearch = true -- highlight all matches on previous search pattern
o.ignorecase = true -- ignore case in search patterns
o.inccommand = "nosplit"
o.incsearch = true
o.laststatus = 2
o.list = true
o.listchars = "nbsp:¬,tab:»·,trail:·,eol:↴"
-- o.mouse = "a" -- allow the mouse to be used in neovim
o.number = true -- set numbered lines
o.numberwidth = 4 -- set number column width to 2 {default 4}
o.path = o.path .. "**"
o.pumheight = 10 -- pop up menu height
o.relativenumber = true -- set relative numbered lines
o.scrolloff = 8 -- is one of my fav
o.shiftwidth = 4 -- the number of spaces inserted for each indentation
o.shortmess = o.shortmess .. "c"
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 0 -- always show tabs
o.sidescrolloff = 6
o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.smartcase = true -- smart case
o.smartindent = true -- make indenting smarter again
o.softtabstop = 4
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = true -- creates a swapfile
o.tabstop = 4 -- insert 2 spaces for a tab
o.tags =
	"tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../../tags,../../../../../../../tags,../../../../../../../../tags,../../../../../../../../../tags,../../../../../../../../../../tags"
o.textwidth = 119
o.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile = true -- enable persistent undo
o.updatetime = 300 -- faster completion (4000ms default)
o.wildignore = o.wildignore
	.. "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.jar,*.png,*.class,*.jpg,*.pdf,*.pst,*.ppt,*.doc,*.xls,*.pptx,*.docx,*.xlsx,*.ico,*.bmp,*.gif,*.7z,*.deb,*.rpm,*.dot,*.exe,*.dll,*.aps,*.chm,*.dat,*.dump,*.mp3,*.mkv,*.mp4 ,*.m4a,*.gz,*.tar,*.tgz,*.mdb,*.msg,*.odt,*.oft,*.pdb,*.ppm,*.pps,*.pub,*.mobi,*.rtf,*.stackdump,*.dump,*.ttf,*.otf,*.tmp,*.temp,*.zip"
o.wildignore = o.wildignore .. "*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite"
o.wrap = true -- display lines as one long line
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- window-local options
wo.number = true
wo.relativenumber = true
-- wo.showmatch = true
wo.cursorline = true
wo.wrap = true

-- buffer-local options
bo.expandtab = true
bo.tabstop = 4
bo.softtabstop = 4
bo.shiftwidth = 4

vim.cmd("filetype plugin indent on")
vim.cmd("set spell!")

-- vim.cmd('command! FixWhitespace :%s/\s\+$//e')

vim.api.nvim_exec(
	[[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
]],
	false
)

require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "gnn",
			scope_incremental = "gnc",
			node_decremental = "gnd",
		},
	},
	indent = {
		enable = true,
	},
})

-- telescope actions for dap
require("telescope").load_extension("dap")
