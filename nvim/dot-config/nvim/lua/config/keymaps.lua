-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shorten function name
local map = vim.keymap.set
map('n', '[b', ':bprevious<CR>', { noremap = true, silent = true, desc = 'previous [b]uffer' })
map('n', ']b', ':bnext<CR>', { noremap = true, silent = true, desc = 'next [b]uffer' })
map('n', '[B', ':bfirst<CR>', { noremap = true, silent = true, desc = 'first [b]uffer' })
map('n', ']B', ':blast<CR>', { noremap = true, silent = true, desc = 'last [b]uffer' })
map('n', '<leader>cx', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { silent = true, noremap = true, desc = "[c]ode diagnostic toggle" })
map('n', '<leader>co', '<Plug>(git-conflict-ours)', { noremap = true, silent = true, desc = '[c]onflict [o]urs' })
map('n', '<leader>ct', '<Plug>(git-conflict-theirs)', { noremap = true, silent = true, desc = '[c]onflict [t]heirs' })
map('n', '<leader>cb', '<Plug>(git-conflict-both)', { noremap = true, silent = true, desc = '[c]onflict [b]oth' })
map('n', '<leader>c0', '<Plug>(git-conflict-none)', { noremap = true, silent = true, desc = '[c]onflict n[0]ne' })
map('n', '[x', '<Plug>(git-conflict-prev-conflict)', { noremap = true, silent = true, desc = '[c]onflict [p]rev' })
map('n', ']x', '<Plug>(git-conflict-next-conflict)', { noremap = true, silent = true, desc = '[c]onflict [n]ext' })
