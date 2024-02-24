-- luacheck: globals vim
---@diagnostic disable: undefined-global

local lualine_ok, lualine = pcall(require, 'lualine')
if not lualine_ok then
  vim.notify 'lualine plugin not loaded!'
  return
end
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox_dark',
    -- component_separators = '|',
    -- section_separators = '',
  },
  -- sections = {
  --   lualine_x = {
  --     {
  --       require("noice").api.statusline.mode.get,
  --       cond = require("noice").api.statusline.mode.has,
  --       color = { fg = "#ff9e64" },
  --     }
  --   },
  -- },
}
