local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- global options
o.swapfile = true
-- o.dir = '/tmp'
if vim.loop.os_uname().sysname:find("Windows", 1, true) and true then
  o.dir = os.getenv("LOCALAPPDATA") .. "\\vim\\swap"
else
  o.dir = os.getenv("XDG_CACHE_HOME") .. "/vim/swap"
end

o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.textwidth = 119
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
o.hidden = true
o.scrolloff = 3
-- o.spell!
o.smartcase = true
o.inccommand = "nosplit"
o.termguicolors = true
o.path = o.path .. "**"
o.splitbelow = true
o.splitright = true
o.tags =
  "ctags,.git/ctags,.svn/ctags,../ctags,../.git/ctags,../.svn/ctags,../../ctags,../../.git/ctags,../../.svn/ctags,../../../ctags,../../../.git/ctags,../../../.svn/ctags;"
o.list = true
o.listchars = "nbsp:¬,tab:»·,trail:·"
o.wildignore = o.wildignore .. "*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite"
o.wildignore =
  o.wildignore ..
  "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.jar,*.png,*.class,*.jpg,*.pdf,*.pst,*.ppt,*.doc,*.xls,*.pptx,*.docx,*.xlsx,*.ico,*.bmp,*.gif,*.7z,*.deb,*.rpm,*.dot,*.exe,*.dll,*.aps,*.chm,*.dat,*.dump,*.mp3,*.mkv,*.mp4 ,*.m4a,*.gz,*.tar,*.tgz,*.mdb,*.msg,*.odt,*.oft,*.pdb,*.ppm,*.pps,*.pub,*.mobi,*.rtf,*.stackdump,*.dump,*.ttf,*.otf,*.tmp,*.temp,*.zip"
o.tags =
  "tags,.git/tags,.svn/tags,../tags,../.git/tags,../.svn/tags,../../tags,../../.git/tags,../../.svn/tags,../../../tags,../../../.git/tags,../../../.svn/tags;"
o.shortmess = o.shortmess .. "c"
o.completeopt = "menuone,noinsert,noselect,preview"
o.signcolumn = "yes"
o.updatetime = 300
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.foldnestmax = 10
o.undofile = 10

-- window-local options
wo.number = true
wo.relativenumber = true
wo.wrap = true
-- wo.showmatch = true
-- wo.colorcolumn = 100
wo.cursorline = true

-- buffer-local options
bo.expandtab = true
bo.tabstop = 4
bo.softtabstop = 4
bo.shiftwidth = 4

--[[
TODO: setstatusline with fugitive
TODO: clipboard
]]
vim.cmd("colorscheme gruvbox")
-- vim.cmd('colorscheme molokai')
-- vim.cmd('colorscheme anotherdark')
-- vim.cmd('colorscheme zenburn')
-- vim.cmd('colorscheme wombat256')
-- vim.cmd('colorscheme whitedust')
-- vim.cmd('colorscheme tutticolori')
-- vim.cmd('colorscheme soso')
-- vim.cmd('colorscheme simpleandfriendly')
-- vim.cmd('colorscheme evening')
-- vim.cmd('colorscheme asmdev')
vim.cmd("filetype plugin indent on")
vim.cmd("set spell!")

local map = vim.api.nvim_set_keymap

-- g...git; f...find; s...session; t...terminal;

-- map the leader key
map("n", ",", "", {})
vim.g.mapleader = "," -- 'vim.g' sets global variables
options = {noremap = true}
-- General
map("i", "jk", "<esc>", options)
map("t", "jk", "<c-\\><c-n>", options)
map("n", "n", "nzzzv", options)
map("n", "N", "Nzzzv", options)
map("n", "Q", "@@", options)
map("c", "W!", "w!", options)
map("c", "Q!", "q!", options)
map("c", "Qa!", "qa!", options)
map("c", "W", "w", options)
map("c", "Q", "Q", options)
-- Vmap for maintain Visual Mode after shifting > and <
map("n", "<", "<gv", options)
map("v", ">", ">gv", options)
-- Move visual block
map("v", "J", ":m >+1<CR>gv=gv", options)
map("v", "K", ":m <-2<CR>gv=gv", options)
-- jump between buffers in normal mode
map("n", "<c-h>", "<c-w>h", options)
map("n", "<c-j>", "<c-w>j", options)
map("n", "<c-k>", "<c-w>k", options)
map("n", "<c-l>", "<c-w>l", options)
-- jump between buffers in visual mode
map("x", "<c-h>", "<c-w>h", options)
map("x", "<c-j>", "<c-w>j", options)
map("x", "<c-k>", "<c-w>k", options)
map("x", "<c-l>", "<c-w>l", options)
-- remove ^M from dos files
map("n", "<leader>m", ":e ++ff=dos<cr>", options)
-- move vertically by visual line
map("n", "j", "gj", options)
map("n", "k", "gk", options)
-- highlight last inserted text
map("n", "gV", "`[v`]", options)
-- Buffer
map("n", "<Leader>h", ":<C-u>split<CR>", options)
map("n", "<Leader>v", ":<C-u>vsplit<CR>", options)
map("n", "<leader>z", ":bp<CR>", options)
map("n", "<leader>x", ":bn<CR>", options)
map("n", "<leader>c", ":bd<CR>", options)
-- session management
map("n", "<leader>so", ":OpenSession<Space>", options)
map("n", "<leader>ss", ":SaveSession<Space>", options)
map("n", "<leader>sd", ":DeleteSession<CR>", options)
map("n", "<leader>sc", ":CloseSession<CR>", options)
-- Vista
map("n", "<Leader>tb", ":Vista!!<CR>", options)
-- GIT
-- map('n', '<Leader>gr', ':Gremove<CR>', options)
map("n", "<Leader>gbr", ":GBranches<CR>", options)
map("n", "<Leader>gt", ":GTags<CR>", options)
-- Open current line on GitHub
map("n", "<Leader>o", ":.Gbrowse<CR>", options)
-- Open applications
map("n", "<leader>s", ":Snippets<CR>", options)
-- Open applications
map("n", "<c-n>", ":NvimTreeToggle<CR>", options)
-- LSP
map("n", "<leader>lf", ":Lspsaga lsp_finder<CR>", options)
map("n", "<leader>la", ":Lspsaga code_action<CR>", options)
map("v", "<leader>la", ":<C-U>Lspsaga range_code_action<CR>", options)
map("n", "K", ":Lspsaga hover_doc<CR>", options)
map("n", "<leader>lS", ":Lspsaga signature_help<CR>", options)
map("n", "<leader>lR", ":Lspsaga rename<CR>", options)
map("n", "<leader>lp", ":Lspsaga preview_definition<CR>", options)
map("n", "<leader>lD", ":Lspsaga show_line_diagnostics<CR>", options)
map("n", "e[", ":Lspsaga diagnostic_jump_next<CR>", options)
map("n", "e]", ":Lspsaga diagnostic_jump_prev<CR>", options)
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", options)
-- rust-analyzer does not yet support goto declaration - re-mapped `gd` to definition
map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
-- map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
-- map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
-- Completion (nvim-comple)
map("i", "<expr> <C-Space>", "compe#complete()", options)
map("i", "<expr> <CR>", "compe#confirm('<CR>')", options)
map("i", "<expr> <C-e>", "compe#close('<C-e>')", options)
map("i", "<expr> <C-f>", "compe#scroll({ 'delta': +4 })", options)
map("i", "<expr> <C-d>", "compe#scroll({ 'delta': -4 })", options)
-- GIT
map("n", "<Leader>ga", ":Gwrite<CR>", options)
map("n", "<Leader>gc", ":Gcommit<CR>", options)
map("n", "<Leader>gsh", ":Gpush<CR>", options)
map("n", "<Leader>gll", ":Gpull<CR>", options)
-- map("n", "<Leader>gs", ":Gstatus<CR>", options)
map("n", "<Leader>gbl", ":Gblame<CR> noremap <Leader>gd :Gvdiff<CR>", options)
-- Fuzzy - old fzf.vim style
-- map("n", "<Leader>f", ":GFiles<CR>", options)
-- map("n", "<Leader>F", ":Files<CR>", options)
-- map("n", "<leader>e", ":FZF -m<CR>", options)
-- map("n", "<Leader>b", ":Buffers<CR>", options)
map("n", "<Leader>y", ":History<CR>", options)
-- map("n", "<Leader>t", ":BTags<CR>", options)
-- map("n", "<Leader>T", ":Tags<CR>", options)
-- map("n", "<Leader>l", ":BLines<CR>", options)
-- map("n", "<Leader>L", ":Lines<CR>", options)
map("n", "<Leader>'", "Marks<CR>", options)
-- map("n", "<Leader>a", ":Rg<Space><CR>", options)
-- map("n", "<Leader>H", ":Helptags!<CR>", options)
-- map("n", "<Leader>C", ":Commands<CR>", options)
map("n", "<Leader>:", ":History:<CR>", options)
map("n", "<Leader>/", ":History/<CR>", options)
map("n", "<Leader>M", ":Maps<CR>", options)
map("n", "<Leader>S", ":Filetypes<CR>", options)
map("n", "<Leader>B", ":BufferPick<CR>", options)
-- Telescope - new native lua style
map("n", "<leader>fA", "<cmd>Telescope autocommands<cr>", options)
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", options)
map("n", "<leader>?", "<cmd>Telescope builtin<cr>", options)
map("n", "<leader>C", "<cmd>Telescope colorscheme<cr>", options)
map("n", "<leader>f:", "<cmd>Telescope command_history<cr>", options)
map("n", "<leader>:", "<cmd>Telescope commands<cr>", options)
map("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", options)
map("n", "<leader>fT", "<cmd>Telescope current_buffer_tags<cr>", options)
-- map("n", "<leader>f$", "<cmd>Telescope fd<cr>", options)
map("n", "<leader>f-", "<cmd>Telescope filetypes<cr>", options)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", options)
map("n", "<leader>f.", '<cmd>Telescope find_files cwd="/home/heiko/.config"<cr>', options)
map("n", "<leader>gB", "<cmd>Telescope git_bcommits<cr>", options)
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", options)
map("n", "<leader>gC", "<cmd>Telescope git_commits<cr>", options)
map("n", "<leader>gf", "<cmd>Telescope git_files<cr>", options)
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", options)
map("n", "<leader>f*", "<cmd>Telescope grep_string<cr>", options)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", options)
map("n", "<leader>fH", "<cmd>Telescope highlights<cr>", options)
map("n", "<leader>fK", "<cmd>Telescope keymaps<cr>", options)
map("n", "<leader>a", "<cmd>Telescope live_grep<cr>", options)
map("n", "<leader>fll", "<cmd>Telescope loclist<cr>", options)
map("n", "<leader>fla", "<cmd>Telescope lsp_code_actions<cr>", options)
map("n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<cr>", options)
map("n", "<leader>flra", "<cmd>Telescope lsp_range_code_actions<cr>", options)
map("n", "<leader>flr", "<cmd>Telescope lsp_references<cr>", options)
map("n", "<leader>flwa", "<cmd>Telescope lsp_workspace_symbols<cr>", options)
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", options)
map("n", "<leader>f'", "<cmd>Telescope marks<cr>", options)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", options)
-- map('n', '<leader>fp', '<cmd>Telescope planets<cr>', options)
map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", options)
map("n", "<leader>fr", "<cmd>Telescope registers<cr>", options)
-- map('n', '<leader>frl', '<cmd>Telescope reloader<cr>', options)
map("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", options)
map("n", "<leader>fk", "<cmd>Telescope symbols<cr>", options)
map("n", "<leader>ft", "<cmd>Telescope tags<cr>", options)
map("n", "<leader>fk", "<cmd>Telescope treesitter<cr>", options)
map("n", "<leader>fO", "<cmd>Telescope vim_options<cr>", options)

-- vim.cmd('command! FixWhitespace :%s/\s\+$//e')

vim.api.nvim_exec([[
	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
]], false)

require("nvim-treesitter.configs").setup(
  {
    ensure_installed = "maintained",
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "gnn",
        scope_incremental = "gnc",
        node_decremental = "gnd"
      }
    },
    indent = {
      enable = true
    },
    rainbow = {
      enable = true
    }
  }
)

-- telescope actions for dap
require("telescope").load_extension("dap")

-- Formatter
require("formatter").setup(
  {
    logging = false,
    filetype = {
      css = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      html = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      yaml = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      javascript = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      go = {
        function()
          return {
            exe = "gofmt",
            args = {""},
            stdin = true
          }
        end
      },
      sh = {
        function()
          return {
            exe = "shfmt",
            stdin = true
          }
        end
      },
      python = {
        function()
          return {
            exe = "black",
            stdin = true
          }
        end
      },
      rust = {
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
augroup END
]],
  true
)

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
