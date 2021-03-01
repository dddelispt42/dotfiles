vim.g.mapleader = ","

require("general")
require("plugins")
require("utils")
require("lsp")

-- TODO: some plugins reset those values
vim.o.signcolumn = "yes"
