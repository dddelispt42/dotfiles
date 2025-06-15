-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.deprecation_warnings = true -- Hide deprecation warnings

local opt = vim.opt
opt.completeopt = "menu,menuone,noinsert,noselect,preview"

vim.g.autoformat = false -- LazyVim auto format
