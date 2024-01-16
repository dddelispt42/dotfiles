-- luacheck: globals vim
---@diagnostic disable: undefined-global

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Fuzzy Finder (files, lsp, etc)
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        -- branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            'nvim-telescope/telescope-symbols.nvim',
            'molecule-man/telescope-menufacture',
            'debugloop/telescope-undo.nvim',
            'ThePrimeagen/harpoon',
            'nvim-telescope/telescope-dap.nvim',
        },
        cmd = 'Telescope',
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = "VeryLazy",
    },
    -- {
    --     'folke/zen-mode.nvim',
    --     dependencies = {
    --         'folke/twilight.nvim',
    --     },
    --     cmd = { 'ZenMode', 'Twilight' },
    -- },
    {
        'glacambre/firenvim',
        build = function()
            vim.fn['firenvim#install'](0)
        end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        config = true,
    },
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
            'jayp0521/mason-nvim-dap.nvim',
            'simrat39/rust-tools.nvim',
        },
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'LostNeophyte/null-ls-embedded',
        },
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'Weissle/persistent-breakpoints.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'saecki/crates.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        event = { "BufRead Cargo.toml" },
    },
    {
        'b0o/schemastore.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'folke/trouble.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {
                auto_open = true,  -- automatically open the list when you have diagnostics
                auto_close = true, -- automatically close the list when you have no diagnostics
                -- automatically preview the location of the diagnostic.
                -- <esc> to close preview and go back to last window
                auto_preview = true,
                mode = 'document_diagnostics',
            }
        end,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'f3fora/cmp-spell',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'ray-x/cmp-treesitter',
            'rcarriga/cmp-dap',
            'saadparwaiz1/cmp_luasnip',
            -- "pontusk/cmp-vimwiki-tags"
        },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { 'rafamadriz/friendly-snippets', },
        build = "make install_jsregexp",
        event = 'InsertEnter'
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'RRethy/nvim-treesitter-endwise',
            'RRethy/nvim-treesitter-textsubjects',
            'windwp/nvim-ts-autotag',
        },
    },
    {
        'nvim-treesitter/completion-treesitter',
        build = function()
            vim.cmd [[TSUpdate]]
        end,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'aklt/plantuml-syntax', -- TODO: check if TS syntax exists
        ft = "plantuml",
    },
    -- 'Sol-Ponz/plantuml-previewer.nvim',
    {
        'javiorfo/nvim-soil',
        ft = 'plantuml',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'sidebar-nvim/sections-dap',
        -- lazy = true,
        dependencies = {
            'sidebar-nvim/sidebar.nvim',
        },
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        build = function()
            vim.g.dap_virtual_text = true
        end,
        dependencies = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
            'mfussenegger/nvim-dap-python',
        },
        cmd = { 'DapUIToggle', 'DapToggleRepl', 'DapToggleBreakpoint' },
    },
    {
        'numToStr/Comment.nvim',
        config = true,
        keys = {
            { 'gcc', mode = { 'n', }, function() require('Comment').toggle() end, desc = "Comment" },
            { 'gc',  mode = { 'v' },  function() require('Comment').toggle() end, desc = "Comment" },
        },
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-neotest/neotest-python',
            'nvim-neotest/neotest-plenary',
            'rouge8/neotest-rust',
        },
        cmd = 'Neotest',
    },
    {
        'folke/todo-comments.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = true,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'tpope/vim-sleuth', -- TODO: is there a lua substitute?
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'kylechui/nvim-surround',
        -- version = '*', -- Use for stability; omit to use `main` branch for the latest features
        -- event = 'VeryLazy',
        keys = { 'cs', 'ds', 'ys' },
        config = function()
            require('nvim-surround').setup {
                keymaps = { -- vim-surround style keymaps
                    -- insert = "ys",
                    -- insert_line = "yss",
                    visual = 'S',
                    delete = 'ds',
                    change = 'cs',
                },
                surrounds = {
                    HTML = {
                        ['t'] = 'type',  -- Change just the tag type
                        ['T'] = 'whole', -- Change the whole tag contents
                    },
                    aliases = {
                        ['a'] = '>', -- Single character aliases apply everywhere
                        ['b'] = ')',
                        ['B'] = '}',
                        ['r'] = ']',
                        -- Table aliases only apply for changes/deletions
                        ['q'] = { '"', "'", '`' },                     -- Any quote character
                        ['s'] = { ')', ']', '}', '>', "'", '"', '`' }, -- Any surrounding delimiter
                    },
                },
                highlight = { -- Highlight before inserting/changing surrounds
                    duration = 2,
                },
            }
        end,
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        keys = { '<space>m', '<space>J', '<space>s' },
        config = function()
            require('treesj').setup {
                -- Use default keymaps
                -- (<space>m - toggle, <space>j - join, <space>s - split)
                -- use_default_keymaps = true,

                -- Node with syntax error will not be formatted
                check_syntax_error = true,

                -- If line after join will be longer than max value,
                -- node will not be formatted
                max_join_length = 120,

                -- hold|start|end:
                -- hold - cursor follows the node/place on which it was called
                -- start - cursor jumps to the first symbol of the node being formatted
                -- end - cursor jumps to the last symbol of the node being formatted
                cursor_behavior = 'hold',

                -- Notify about possible problems or not
                notify = true,
                -- langs = langs,

                -- Use `dot` for repeat action
                dot_repeat = true,
            }
        end,
    },
    {
        'NeogitOrg/neogit',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'akinsho/git-conflict.nvim',
        config = true,
        event = { "BufReadPre", "BufNewFile" }
    },
    {
        'tpope/vim-fugitive', -- TODO: is there a lua substitute?
        cmd = 'Git',
    },
    -- 'tpope/vim-rhubarb', -- required by fugitive to :Gbrowse
    {
        'ThePrimeagen/refactoring.nvim',
        event = 'LspAttach',
    },
    {
        'sindrets/diffview.nvim',
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'yamatsum/nvim-cursorline',
        event = 'VeryLazy',
    },
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme gruvbox]]
        end,
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup {}
        end,
        event = 'VeryLazy',
    },
    {
        'vimwiki/vimwiki', -- TODO: is there a lua substitute?
        ft = 'vimwiki',
    },
    -- 'tpope/vim-repeat',      -- TODO: is there a lua substitute?
    {
        'tpope/vim-speeddating', -- TODO: is there a lua substitute?
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            -- search = {
            --     mode = function(str)
            --         return '\\<' .. str
            --     end,
            -- },
        },
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                'S',
                mode = { 'n', 'o', 'x' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                'R',
                mode = { 'o', 'x' },
                function()
                    require('flash').treesitter_search()
                end,
                desc = 'TS Search',
            },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },
    {
        'folke/which-key.nvim',
        config = true,
        event = 'VeryLazy',
    },
    {
        'will133/vim-dirdiff', -- TODO: is there a lua substitute?
        cmd = "DirDiff",
    },
    -- 'christoomey/vim-conflicted',  -- TODO: is there a lua substitute?
    {
        'christoomey/vim-sort-motion', -- TODO: is there a lua substitute?
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'aserowy/tmux.nvim',
        event = function()
            if vim.fn.exists('$TMUX') == 1 then
                return 'VeryLazy'
            end
        end,
        config = function()
            return require('tmux').setup()
        end,
    },
    -- 'brooth/far.vim',   -- TODO: is there a lua substitute?
    -- " allows opening files at specific location - e.g. /tmp/bal:10:2
    'wsdjeg/vim-fetch', -- TODO: is there a lua substitute?
    -- " Plug 'henrik/vim-open-url'
    -- 'romainl/vim-cool',
    -- " better encryption plugin - dependencies: https://github.com/jedisct1/encpipe
    -- 'hauleth/vim-encpipe', -- TODO: is there a lua substitute?
    -- " floating windows
    -- 'machakann/vim-highlightedyank',
    {
        'voldikss/vim-floaterm', -- TODO: is there a lua substitute?
        event = "VeryLazy",
    },
    -- edit JIRA issues in vim
    -- 'n0v1c3/vira0,
    -- 'dddelispt42/vira', { 'do': './install.sh', }
    -- 'n0v1c3/vira',
    -- " automatically set the root directory
    {
        'airblade/vim-rooter', -- TODO: is there a lua substitute?
        event = "VeryLazy",
    },
    -- 'github/copilot.vim',
    -- {
    --     'nvim-neorg/neorg',
    --     ft = 'norg',
    --     build = ':Neorg sync-parsers', -- This is the important bit!
    --     dependencies = 'nvim-lua/plenary.nvim',
    -- },
    {
        'tversteeg/registers.nvim',
        event = 'VeryLazy',
        config = function()
            local registers = require 'registers'
            registers.setup {}
        end,
    },
    {
        'rcarriga/nvim-notify',
        event = 'VeryLazy',
        cmd = 'Notificaitons'
    },
    {
        'nvim-orgmode/orgmode',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    -- { 'michaelb/sniprun', build = 'bash ./install.sh' },
    {
        'dhruvasagar/vim-table-mode', -- TODO: is there a lua substitute?
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'rest-nvim/rest.nvim',
        cmd = { "RestNvim", "RestNvimPreview", "RestNvimLast" },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    -- {
    --     'Exafunction/codeium.vim',
    --     event = 'VimEnter',
    --     config = function()
    --         -- Change '<C-g>' here to any keycode you like.
    --         vim.keymap.set('i', '<C-g>', function()
    --             return vim.fn['codeium#Accept']()
    --         end, { expr = true })
    --     end,
    -- },
    {
        'jackMort/ChatGPT.nvim',
        event = 'VeryLazy',
        config = function()
            require('chatgpt').setup {
                -- optional configuration
                popup_input = {
                    submit = '<M-Enter>',
                },
            }
        end,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
    },
}, {
    -- defaults = { lazy = false },
})
