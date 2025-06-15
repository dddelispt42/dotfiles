-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Hide deprecation warnings
vim.g.deprecation_warnings = true

local opt = vim.opt
opt.completeopt = "menu,menuone,noinsert,noselect,preview"
