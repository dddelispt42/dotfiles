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
require("cursorline_config")
require("orgmode_config")
require("null-ls_config")
require("lsp")
require("git_config")
require("debug_config")
