-- luacheck: globals vim
vim.g.mapleader = ","

require("general")
require("keymaps")
require("plugins")
require("utils")
require("treesitter_config")
require("gitsigns_config")
require("completion_config")
require("colors")
require("bufferline_config")
require("orgmode_config")
if os.getenv("OS") ~= "Windows_NT" then
	require("null-ls_config")
	require("lsp")
	require("debug_config")
end
