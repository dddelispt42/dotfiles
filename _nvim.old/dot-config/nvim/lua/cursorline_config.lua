---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local cursorline_ok, cursorline = pcall(require, 'nvim-cursorline')
if not cursorline_ok then
    vim.notify 'nvim-cursorline plugin not loaded!'
    return
end

cursorline.setup {
    cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    },
}
