-- luacheck: globals vim
---@diagnostic disable: undefined-global

local lualine_ok, lualine = pcall(require, 'lualine')
if lualine_ok then
  lualine.setup {
    options = {
      icons_enabled = true,
      theme = 'gruvbox_dark',
      -- component_separators = '|',
      -- section_separators = '',
    },
  }
end
