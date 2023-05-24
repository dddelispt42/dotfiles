-- luacheck: globals vim
local neotest_ok, neotest = pcall(require, 'neotest')
if not neotest_ok then
    return
end
neotest.setup {
    adapters = {
        require 'neotest-python' {
            dap = { justMyCode = false },
        },
        require 'neotest-rust' {
            dap = { justMyCode = false },
        },
        require 'neotest-plenary',
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
map('n', '<leader>tc', '<cmd>require("neotest").run.run(vim.fm.expand("&"))<cr>', {
    noremap = true,
    silent = true,
    desc = '[t]est [n]nearest',
})
map('n', '<leader>td', '<cmd>require("neotest").run.run({strategy = "dap"})<cr>', {
    noremap = true,
    silent = true,
    desc = '[t]est [d]ebug nearest test',
})
