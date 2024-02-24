-- luacheck: globals vim
---@diagnostic disable: undefined-global

vim.opt.termguicolors = true -- enable true-color support
vim.o.background = 'dark'    -- or "light" for light mode

local colorscheme = 'gruvbox'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

local colorizer_ok, colorizer = pcall(require, 'colorizer')
if not colorizer_ok then
    vim.notify 'colorizer plugin not loaded!'
    return
end
colorizer.setup()
