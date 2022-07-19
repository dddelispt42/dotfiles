-- luacheck: globals vim

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
-- Shorten function name
local map = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Convention:
--   g...git
--   f...find
--   l...LSP stuff
--   s...session
--   t...terminal

-- map the leader key
map("n", ",", "", {})
vim.g.mapleader = "," -- 'vim.g' sets global variables
vim.g.maplocalleader = ","
-- General
map("i", "jk", "<esc>", opts)
map("t", "jk", "<c-\\><c-n>", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "Q", "@@", opts)
-- map("c", "W!", "w!", opts)
map("c", "W!", "w !doas tee %", opts) -- write as root
map("c", "Q!", "q!", opts)
map("c", "Qa!", "qa!", opts)
-- Vmap for maintain Visual Mode after shifting > and <
map("n", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- Move visual block
map("v", "J", ":m +1<CR>gv=gv", opts)
map("v", "K", ":m -2<CR>gv=gv", opts)
-- jump between buffers in normal mode
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)
map("n", "<c-l>", "<c-w>l", opts)
-- jump between buffers in visual mode
map("x", "<c-h>", "<c-w>h", opts)
map("x", "<c-j>", "<c-w>j", opts)
map("x", "<c-k>", "<c-w>k", opts)
map("x", "<c-l>", "<c-w>l", opts)
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- remove ^M from dos files
map("n", "<leader>m", ":e ++ff=dos<cr>", opts)
-- move vertically by visual line
-- TODO: make those a bit more intelligent - single step is j, move is gj
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
-- highlight last inserted text
map("n", "gV", "`[v`]", opts)
-- Buffer
map("n", "<Leader>h", ":<C-u>split<CR>", opts)
map("n", "<Leader>v", ":<C-u>vsplit<CR>", opts)
map("n", "<leader>z", ":bp<CR>", opts)
map("n", "<leader>x", ":bn<CR>", opts)
map("n", "<leader>c", ":bd<CR>", opts)
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
-- session management
map("n", "<leader>so", ":OpenSession<Space>", opts)
map("n", "<leader>ss", ":SaveSession<Space>", opts)
map("n", "<leader>sd", ":DeleteSession<CR>", opts)
map("n", "<leader>sc", ":CloseSession<CR>", opts)
-- Vista
-- map("n", "<Leader>tb", ":Vista!!<CR>", opts)
map("n", "<Leader>tb", ":SidebarNvimToggle<CR>", opts)

-- LSP
map("n", "<leader>lf", ":Lspsaga lsp_finder<CR>", opts)
-- map("n", "<leader>la", ":Lspsaga code_action<CR>", opts)
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("v", "<leader>la", ":<C-U>Lspsaga range_code_action<CR>", opts)
-- map("n", "K", ":Lspsaga hover_doc<CR>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<leader>lS", ":Lspsaga signature_help<CR>", opts)
-- map("n", "<leader>lR", ":Lspsaga rename<CR>", opts)
map("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>lp", ":Lspsaga preview_definition<CR>", opts)
-- map("n", "<leader>lD", ":Lspsaga show_line_diagnostics<CR>", opts)
-- map("n", "e[", ":Lspsaga diagnostic_jump_next<CR>", opts)
-- map("n", "e]", ":Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "e[", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "e]", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- rust-analyzer does not yet support goto declaration - re-mapped `gd` to definition
map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- map("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- Open applications
map("n", "<c-n>", ":NvimTreeToggle<CR>", opts)
map("n", "<Leader>gd", ":Gvdiff<CR>", opts)

-- Telescope - new native lua style
map("n", "<leader>fA", "<cmd>Telescope autocommands<cr>", opts)
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>?", "<cmd>Telescope builtin<cr>", opts)
map("n", "<leader>C", "<cmd>Telescope colorscheme<cr>", opts)
map("n", "<leader>f:", "<cmd>Telescope command_history<cr>", opts)
map("n", "<leader>:", "<cmd>Telescope commands<cr>", opts)
map("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
map("n", "<leader>fT", "<cmd>Telescope current_buffer_tags<cr>", opts)
-- map("n", "<leader>f$", "<cmd>Telescope fd<cr>", opts)
map("n", "<leader>f-", "<cmd>Telescope filetypes<cr>", opts)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>f.", '<cmd>Telescope find_files cwd="/home/heiko/.config"<cr>', opts)
map("n", "<leader>gB", "<cmd>Telescope git_bcommits<cr>", opts)
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)
map("n", "<leader>gC", "<cmd>Telescope git_commits<cr>", opts)
map("n", "<leader>gf", "<cmd>Telescope git_files<cr>", opts)
map("n", "<leader>gS", "<cmd>Telescope git_status<cr>", opts)
map("n", "<leader>f*", "<cmd>Telescope grep_string<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>fH", "<cmd>Telescope highlights<cr>", opts)
map("n", "<leader>fK", "<cmd>Telescope keymaps<cr>", opts)
map("n", "<leader>a", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fll", "<cmd>Telescope loclist<cr>", opts)
map("n", "<leader>fla", "<cmd>Telescope lsp_code_actions<cr>", opts)
map("n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<cr>", opts)
map("n", "<leader>flra", "<cmd>Telescope lsp_range_code_actions<cr>", opts)
map("n", "<leader>flr", "<cmd>Telescope lsp_references<cr>", opts)
map("n", "<leader>flwa", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", opts)
map("n", "<leader>f'", "<cmd>Telescope marks<cr>", opts)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
-- map('n', '<leader>fp', '<cmd>Telescope planets<cr>', opts)
map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", opts)
map("n", "<leader>fr", "<cmd>Telescope registers<cr>", opts)
-- map('n', '<leader>frl', '<cmd>Telescope reloader<cr>', opts)
map("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", opts)
map("n", "<leader>fk", "<cmd>Telescope symbols<cr>", opts)
map("n", "<leader>ft", "<cmd>Telescope tags<cr>", opts)
map("n", "<leader>fk", "<cmd>Telescope treesitter<cr>", opts)
map("n", "<leader>fO", "<cmd>Telescope vim_options<cr>", opts)

map(
	"n",
	"<space>f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, "
		.. "current_line_only = false })<cr>",
	{}
)
map(
	"n",
	"<space>F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, "
		.. "current_line_only = false })<cr>",
	{}
)
map(
	"o",
	"<space>f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, "
		.. "current_line_only = false, inclusive_jump = true })<cr>",
	{}
)
map(
	"o",
	"<space>F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, "
		.. "current_line_only = false, inclusive_jump = true })<cr>",
	{}
)
map(
	"",
	"<space>t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, "
		.. "current_line_only = false })<cr>",
	{}
)
map(
	"",
	"<space>T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, "
		.. "current_line_only = false })<cr>",
	{}
)

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
map("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

-- GUI mode - zooms
map("n", "<C-ScrollWheelUp>", "<cmd>AdjustFontSize(1)<CR>", { silent = true, noremap = true })
map("n", "<C-ScrollWheelDown>", "<cmd>AdjustFontSize(-1)<CR>", { silent = true, noremap = true })
map("i", "<C-ScrollWheelUp>", "<Esc><cmd>AdjustFontSize(1)<CR>a", { silent = true, noremap = true })
map("i", "<C-ScrollWheelDown>", "<Esc><cmd>AdjustFontSize(-1)<CR>a", { silent = true, noremap = true })

-- Debugging
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", opts)
map("n", "<leader>dc", "<cmd>DapContinue<cr>", opts)
map("n", "<leader>di", "<cmd>DapStepInto<cr>", opts)
map("n", "<leader>do", "<cmd>DapStepOver<cr>", opts)
map("n", "<leader>du", "<cmd>DapStepOut<cr>", opts)
map("n", "<leader>dr", "<cmd>DapToggleRepl<cr>", opts)
