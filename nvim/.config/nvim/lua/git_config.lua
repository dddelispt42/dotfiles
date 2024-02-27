---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local neogit_ok, neogit = pcall(require, 'neogit')
if not neogit_ok then
  vim.notify 'neogit plugin not loaded!'
  return
end

neogit.setup {}

local gitconflict_ok, gitconflict = pcall(require, 'git-conflict')
if not gitconflict_ok then
  vim.notify 'git-conflict plugin not loaded!'
  return
end

gitconflict.setup {
  default_mappings = true,       -- disable buffer local mapping created by this plugin
  default_commands = true,       -- disable commands created by this plugin
  disable_diagnostics = false,   -- This will disable the diagnostics in a buffer whilst it is conflicted
  highlights = {                 -- They must have background color, otherwise the default color will be used
    incoming = 'DiffText',
    current = 'DiffAdd',
  },
}

vim.keymap.set('n', '<leader>co', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', '<leader>ct', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', '<leader>cb', '<Plug>(git-conflict-both)')
vim.keymap.set('n', '<leader>c0', '<Plug>(git-conflict-none)')
vim.keymap.set('n', ']c', '<Plug>(git-conflict-prev-conflict)')
vim.keymap.set('n', '[c', '<Plug>(git-conflict-next-conflict)')
