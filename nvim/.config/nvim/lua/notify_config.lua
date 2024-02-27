---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local notify_ok, notify = pcall(require, 'notify')
if not notify_ok then
    vim.notify 'notify plugin not loaded!'
    return
end

notify.setup()
vim.notify = notify
