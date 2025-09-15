-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shorten function name
local map = vim.keymap.set
map('n', '[b', ':bprevious<CR>', { noremap = true, silent = true, desc = 'previous [b]uffer' })
map('n', ']b', ':bnext<CR>', { noremap = true, silent = true, desc = 'next [b]uffer' })
map('n', '[B', ':bfirst<CR>', { noremap = true, silent = true, desc = 'first [b]uffer' })
map('n', ']B', ':blast<CR>', { noremap = true, silent = true, desc = 'last [b]uffer' })
