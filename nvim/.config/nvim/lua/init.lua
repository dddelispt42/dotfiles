-- luacheck: globals vim
vim.g.mapleader = ","

require("general")
require("keymaps")
require("plugins")
require("utils")
require("null-ls_config")
require("treesitter_config")
require("gitsigns_config")
require("completion_config")
require("lsp")
require("colors")
require("bufferline_config")
require("debug_config")
