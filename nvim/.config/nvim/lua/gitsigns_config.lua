---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
    vim.notify 'gitsigns plugin not loaded!'
    return
end

gitsigns.setup {
    signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = true,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
    },
}
local map = vim.keymap.set
map('n', '<leader>gm', '<cmd>Gitsign blame_line<cr>', {
    noremap = true,
    silent = true,
    desc = '[g]it [m]essage from git blame',
})
map('n', '[g', '<cmd>Gitsign prev_hunk<cr>', { noremap = true, silent = true, desc = '[[g]it - previous hunk' })
map('n', ']g', '<cmd>Gitsign next_hunk<cr>', { noremap = true, silent = true, desc = '[]g]it - next hunk' })
