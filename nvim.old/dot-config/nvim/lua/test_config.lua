---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local neotest_ok, neotest = pcall(require, 'neotest')
if not neotest_ok then
    vim.notify 'neotest plugin not loaded!'
    return
end
neotest.setup {
    adapters = {
        require 'neotest-python' {
            dap = { justMyCode = false },
        },
        -- require 'neotest-rust' {
        --     dap = { justMyCode = false },
        -- },
        require 'neotest-plenary',
        require 'rustaceanvim.neotest' {
            dap = { justMyCode = false },
        },
        -- require 'neotest-vim-test' {
        --     ignore_file_types = { 'python', 'vim', 'lua' },
        -- },
    },
}

local map = vim.keymap.set
map('n', '<leader>tn', '<cmd>require("neotest").run.run()<cr>', {
    noremap = true,
    silent = true,
    desc = '[t]est [n]nearest',
})
map('n', '<leader>ta', '<cmd>require("neotest").run.run(vim.fn.expand("%"))<cr>', {
    noremap = true,
    silent = true,
    desc = '[t]est [a]ll tests in buffer',
})
map('n', '<leader>td', '<cmd>require("neotest").run.run({strategy = "dap"})<cr>', {
    noremap = true,
    silent = true,
    desc = '[t]est [d]ebug nearest test',
})
map('n', '<leader>tw', '<cmd>Neotest watch', {
    noremap = true,
    silent = true,
    desc = '[t]est [w]atch',
})
map('n', '<leader>to', '<cmd>Neotest output', {
    noremap = true,
    silent = true,
    desc = '[t]est [o]utput',
})
map('n', '<leader>ts', '<cmd>Neotest summary', {
    noremap = true,
    silent = true,
    desc = '[t]est [s]ummary',
})
map('n', '<leader>tD', '<cmd>Neotest diagnostic', {
    noremap = true,
    silent = true,
    desc = '[t]est [D]iagnostic',
})
