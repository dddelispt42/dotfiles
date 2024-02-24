-- luacheck: globals vim
---@diagnostic disable: undefined-global

local notify_ok, notify = pcall(require, 'notify')
if not notify_ok then
    vim.notify 'notify plugin not loaded!'
    return
end

notify.setup()
vim.notify = notify
