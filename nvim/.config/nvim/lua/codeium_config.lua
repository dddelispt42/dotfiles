-- luacheck: globals vim
vim.g.codeium_enabled = true
vim.g.codeium_disable_bindings = 1
vim.g.codeium_filetypes = {
    bash = true,
    typescript = true,
    rust = true,
    python = true,
    lua = true,
    org = false,
    norg = false,
    markdown = false,
    text = false,
}
vim.keymap.set('i', '<C-m>', function()
    return vim.fn['codeium#Accept']()
end, { expr = true })
vim.keymap.set('i', '<c-;>', function()
    return vim.fn['codeium#CycleCompletions'](1)
end, { expr = true })
vim.keymap.set('i', '<c-,>', function()
    return vim.fn['codeium#CycleCompletions'](-1)
end, { expr = true })
vim.keymap.set('i', '<c-x>', function()
    return vim.fn['codeium#Clear']()
end, { expr = true })
