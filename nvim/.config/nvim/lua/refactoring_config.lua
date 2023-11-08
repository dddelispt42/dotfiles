-- luacheck: globals vim
---@diagnostic disable: undefined-global

local refact_ok, refact = pcall(require, 'refactoring')
if not refact_ok then
    return
end
refact.setup {}

-- Remaps for each of the four debug operations currently offered by the plugin
vim.api.nvim_set_keymap(
    'v',
    '<Leader>re',
    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
    { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
    'v',
    '<Leader>rf',
    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
    { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
    'v',
    '<Leader>rv',
    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
    { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
    'v',
    '<Leader>ri',
    [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
    'n',
    '<Leader>ri',
    [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    { noremap = true, silent = true, expr = false }
)

-- load refactoring Telescope extension
local tele_ok, tele = pcall(require, 'telescope')
if not tele_ok then
    return
end
tele.load_extension 'refactoring'

-- remap to open the Telescope refactoring menu in visual mode
vim.keymap.set('v', '<leader>rr', tele.extensions.refactoring.refactors, { noremap = true })
