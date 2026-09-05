-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shorten function name
local map = vim.keymap.set
map('n', '[b', ':bprevious<CR>', { noremap = true, silent = true, desc = 'previous [b]uffer' })
map('n', ']b', ':bnext<CR>', { noremap = true, silent = true, desc = 'next [b]uffer' })
map('n', '[B', ':bfirst<CR>', { noremap = true, silent = true, desc = 'first [b]uffer' })
map('n', ']B', ':blast<CR>', { noremap = true, silent = true, desc = 'last [b]uffer' })
map('n', '<leader>ct', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { silent = true, noremap = true, desc = "[c]ode diagnostic [t]oggle" })
-- Conflict resolution keys are defined in plugins/git-conflict.lua
-- Register picker via snacks (alternative to registers.nvim)
map({ 'n', 'x' }, '<leader>r', function() require('snacks').picker.registers() end, { desc = '[R]egister picker' })
-- Tmux-aware window navigation (replaces LazyVim's <C-hjkl> which only does nvim windows)
-- tmux.nvim handles moving between nvim windows and tmux panes seamlessly
map('n', '<C-h>', function() pcall(require('tmux').move_left) end, { desc = 'Left window/pane' })
map('n', '<C-j>', function() pcall(require('tmux').move_bottom) end, { desc = 'Bottom window/pane' })
map('n', '<C-k>', function() pcall(require('tmux').move_top) end, { desc = 'Top window/pane' })
map('n', '<C-l>', function() pcall(require('tmux').move_right) end, { desc = 'Right window/pane' })
