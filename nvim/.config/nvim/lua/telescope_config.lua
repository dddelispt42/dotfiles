---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local tele_ok, tele = pcall(require, 'telescope')
if not tele_ok then
    vim.notify 'telescope plugin not loaded!'
    return
end

local actions = require 'telescope.actions'
local telescopeConfig = require 'telescope.config'
local action_layout = require 'telescope.actions.layout'

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, '--hidden')
-- I don't want to /earch in the `.git` directory.
table.insert(vimgrep_arguments, '--glob')
table.insert(vimgrep_arguments, '!**/{.venv,.git}/*')
--
-- Enable telescope fzf native, if installed
pcall(tele.load_extension, 'fzf')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
tele.setup {
    defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,

        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                width = { padding = 0.1 },
                height = { padding = 0.1 },
                preview_width = 0.5,
            },
        },
        mappings = {
            n = {
                ['<M-p>'] = action_layout.toggle_preview,
            },
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                ['<M-p>'] = action_layout.toggle_preview,
            },
        },
    },
    pickers = {
        find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/{.venv,.git}/*' },
        },
        git_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/{.venv,.git}/*' },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
}

-- telescope actions for dap
tele.load_extension 'dap'
tele.load_extension 'undo'

-- telescope related keymappings
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
map('n', '<leader>fS', '<cmd>Telescope symbols<cr>', { noremap = true, silent = true, desc = '[f]ind [S]ymbols' })
map('n', '<leader>:', '<cmd>Telescope commands<cr>', {
    noremap = true,
    silent = true,
    desc = 'find [:] neovim commands',
})
map('n', '<leader>/', function()
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
map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[f]ind [f]iles' })
map('n', '<leader>f.', '<cmd>Telescope find_files cwd="/home/heiko/.config"<cr>', { noremap = true, silent = true })
map('n', '<leader>gB', '<cmd>Telescope git_bcommits<cr>', { noremap = true, silent = true, desc = '[f]ind [B]commits' })
map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { noremap = true, silent = true, desc = '[f]ind [b]ranches' })
map('n', '<leader>gC', '<cmd>Telescope git_commits<cr>', { noremap = true, silent = true, desc = '[f]ind [C]ommits' })
map('n', '<leader>gf', "<CMD>lua require'telescope_findfiles_config'.project_files()<CR>",
    { noremap = true, silent = true, desc = '[g]it [f]ile finder' })
map('n', '<leader>gS', '<cmd>Telescope git_status<cr>', { noremap = true, silent = true, desc = '[g]it [S]tatus' })
map('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[f]ind current [w]ord' })
map('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[f]ind [h]elp' })
map('n', '<leader>fH', '<cmd>Telescope highlights<cr>', { noremap = true, silent = true, desc = '[f]ind [H]ighlights' })
map('n', '<leader>fK', '<cmd>Telescope keymaps<cr>', { noremap = true, silent = true, desc = '[f]ind [K]eymaps' })
map('n', '<leader>fj', '<cmd>Telescope jumplist<cr>', { noremap = true, silent = true, desc = '[f]ind [j]umplist' })
map('n', '<leader>a', require('telescope.builtin').live_grep, { desc = 'Find by live grep [a]' })
map('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[f]ind [d]iagnostics' })
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
map('n', '<leader>fn', '<cmd>Telescope notify<cr>', { noremap = true, silent = true, desc = '[f]ind [n]otify' })
map('n', "<leader>f'", '<cmd>Telescope marks<cr>', { noremap = true, silent = true, desc = "[f]ind ['] marks" })
map('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[f]ind recently [o]pened files' })
-- map('n', '<leader>fp', '<cmd>Telescope planets<cr>', { noremap = true, silent = true, desc = '[f]ind [p]lanets' })
map('n', '<leader>fq', '<cmd>Telescope quickfix<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [q]uickfix list',
})
map('n', '<leader>fr', '<cmd>Telescope registers<cr>', { noremap = true, silent = true, desc = '[f]ind [r]egisters' })
-- map('n', '<leader>fR', '<cmd>Telescope reloader<cr>', { noremap = true, silent = true, desc = '[f]ind [R]eloader' })
map('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>', { noremap = true, silent = true, desc = '[f]ind [s]pell' })
map('n', '<leader>fu', '<cmd>Telescope undo<cr>', { noremap = true, silent = true, desc = '[f]ind [u]ndos' })
-- map('n', '<leader>fT', '<cmd>Telescope current_buffer_tags<cr>', {
--     noremap = true,
--     silent = true,
--     desc = '[f]ind [T]ags in current buffer',
-- })
map('n', '<leader>fT', '<cmd>TodoTelescope<cr>', { noremap = true, silent = true, desc = '[f]ind [T]ODOs globally' })
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
