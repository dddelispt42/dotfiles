-- luacheck: globals vim
local tele_ok, tele = pcall(require, 'telescope')
if not tele_ok then
    return
end

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
tele.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(tele.load_extension, 'fzf')

local map = vim.keymap.set
-- Telescope - new native lua style
map('n', '<leader>fA', '<cmd>Telescope autocommands<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [A]utocommand',
})
map('n', '<leader>b', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true, desc = 'find [b]uffer' })
map('n', '<leader>?', '<cmd>Telescope builtin<cr>', {
    noremap = true,
    silent = true,
    desc = '[?] find telescope buildins',
})
map('n', '<leader>C', '<cmd>Telescope colorscheme<cr>', {
    noremap = true,
    silent = true,
    desc = 'find [C]olorscheme',
})
map('n', '<leader>f:', '<cmd>Telescope command_history<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [:] commands',
})
map('n', '<leader>:', '<cmd>Telescope commands<cr>', {
    noremap = true,
    silent = true,
    desc = 'find [:] neovim commands',
})
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })
map('n', '<leader>f-', '<cmd>Telescope filetypes<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [-] file types',
})
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[f]ind [f]iles' })
-- map('n', '<leader>f.', '<cmd>Telescope find_files cwd="/home/heiko/.config"<cr>', { noremap = true, silent = true })
map('n', '<leader>gB', '<cmd>Telescope git_bcommits<cr>', { noremap = true, silent = true, desc = '[f]ind [B]commits' })
map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { noremap = true, silent = true, desc = '[f]ind [b]ranches' })
map('n', '<leader>gC', '<cmd>Telescope git_commits<cr>', { noremap = true, silent = true, desc = '[f]ind [C]ommits' })
map('n', '<leader>gf', '<cmd>Telescope git_files<cr>', { noremap = true, silent = true, desc = '[g]it [f]ile finder' })
map('n', '<leader>gS', '<cmd>Telescope git_status<cr>', { noremap = true, silent = true, desc = '[g]it [S]tatus' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[f]ind current [w]ord' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[f]ind [h]elp' })
map('n', '<leader>fH', '<cmd>Telescope highlights<cr>', { noremap = true, silent = true, desc = '[f]ind [H]ighlights' })
map('n', '<leader>fK', '<cmd>Telescope keymaps<cr>', { noremap = true, silent = true, desc = '[f]ind [K]eymaps' })
map('n', '<leader>fj', '<cmd>Telescope jumplist<cr>', { noremap = true, silent = true, desc = '[f]ind [j]umplist' })
vim.keymap.set('n', '<leader>a', require('telescope.builtin').live_grep, { desc = 'Find by live grep [a]' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[f]ind [d]iagnostics' })
map('n', '<leader>fll', '<cmd>Telescope loclist<cr>', { noremap = true, silent = true, desc = '[f]ind [l]oclist' })
map('n', '<leader>fla', '<cmd>Telescope lsp_code_actions<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp code [a]ction',
})
map('n', '<leader>fls', '<cmd>Telescope lsp_document_symbols<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp document [s]ymbols',
})
map('n', '<leader>flS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp workspace [s]ymbols',
})
map('v', '<leader>fla', '<cmd>Telescope lsp_range_code_actions<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp code [a]ctions',
})
map('n', '<leader>flr', '<cmd>Telescope lsp_references<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp [r]eferences',
})
map('n', '<leader>flw', '<cmd>Telescope lsp_workspace_symbols<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp [w]orkspace symbols',
})
map('n', '<leader>fm', '<cmd>Telescope man_pages<cr>', { noremap = true, silent = true, desc = '[f]ind [m]an pages' })
map('n', "<leader>f'", '<cmd>Telescope marks<cr>', { noremap = true, silent = true, desc = "[f]ind ['] marks" })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[f]ind recently [o]pened files' })
-- map('n', '<leader>fp', '<cmd>Telescope planets<cr>', { noremap = true, silent = true, desc = '[f]ind [p]lanets' })
map('n', '<leader>fq', '<cmd>Telescope quickfix<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [q]uickfix list',
})
map('n', '<leader>fr', '<cmd>Telescope registers<cr>', { noremap = true, silent = true, desc = '[f]ind [r]egisters' })
-- map('n', '<leader>fR', '<cmd>Telescope reloader<cr>', { noremap = true, silent = true, desc = '[f]ind [R]eloader' })
map('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>', { noremap = true, silent = true, desc = '[f]ind [s]pell' })
map('n', '<leader>fk', '<cmd>Telescope symbols<cr>', { noremap = true, silent = true, desc = '[f]ind [k] symbols' })
map('n', '<leader>fT', '<cmd>Telescope current_buffer_tags<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [T]ags in current buffer',
})
map('n', '<leader>ft', '<cmd>Telescope tags<cr>', { noremap = true, silent = true, desc = '[f]ind [t]ags globally' })
map('n', '<leader>fk', '<cmd>Telescope treesitter<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [k] treesitter symbols',
})
map('n', '<leader>fO', '<cmd>Telescope vim_options<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind neovim [o]ptions',
})
