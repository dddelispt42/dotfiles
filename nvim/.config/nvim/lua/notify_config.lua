local notify_ok, notify = pcall(require, 'notify')
if not notify_ok then
    return
end

notify.setup()
vim.notify = notify
