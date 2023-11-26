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
    -- { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1,
    },
    'norcalli/nvim-colorizer.lua',
    {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
    },
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
        },
    },
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
    'LostNeophyte/null-ls-embedded',
    'jayp0521/mason-nvim-dap.nvim',
    'simrat39/rust-tools.nvim',
    {
        'saecki/crates.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
    },
    'b0o/schemastore.nvim',
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
    },
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'L3MON4D3/LuaSnip',
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
    'rafamadriz/friendly-snippets',
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        event = 'VimEnter',
        -- event = 'VeryLazy',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
    },
    -- {
    --     'nvim-treesitter/playground',
    --     cmd = 'TSPlaygroundToggle',
    -- },
    {
        'nvim-treesitter/completion-treesitter',
        build = function()
            vim.cmd [[TSUpdate]]
        end,
    },
    'aklt/plantuml-syntax', -- TODO: check if TS syntax exists
    -- 'Sol-Ponz/plantuml-previewer.nvim',
    { 'javiorfo/nvim-soil',            ft = 'plantuml' },
    {
        'sidebar-nvim/sections-dap',
        -- lazy = true,
        dependencies = {
            'sidebar-nvim/sidebar.nvim',
        },
    },
    { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
    'mfussenegger/nvim-dap-python',
    'nvim-telescope/telescope-dap.nvim',
    {
        'theHamsta/nvim-dap-virtual-text',
        build = function()
            vim.g.dap_virtual_text = true
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = true,
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
        event = 'VeryLazy',
    },
    {
        'folke/todo-comments.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = true,
    },
    'tpope/vim-sleuth', -- TODO: is there a lua substitute?
    {
        {
            'lukas-reineke/indent-blankline.nvim',
            main = 'ibl',
            opts = {},
        },
    },
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = 'VeryLazy',
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
    'NeogitOrg/neogit',
    'lewis6991/gitsigns.nvim',
    'akinsho/git-conflict.nvim',
    'tpope/vim-fugitive', -- TODO: is there a lua substitute?
    'tpope/vim-rhubarb',  -- required by fugitive to :Gbrowse
    'ThePrimeagen/refactoring.nvim',
    'sindrets/diffview.nvim',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    'yamatsum/nvim-cursorline',
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
    },
    -- 'romgrk/barbar.nvim',
    {
        'vimwiki/vimwiki', -- TODO: is there a lua substitute?
        ft = 'vimwiki',
    },
    'tpope/vim-repeat',      -- TODO: is there a lua substitute?
    'tpope/vim-speeddating', -- TODO: is there a lua substitute?
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
    },
    -- " Plug 'mjbrownie/hackertyper.vim'
    'will133/vim-dirdiff',         -- TODO: is there a lua substitute?
    'christoomey/vim-conflicted',  -- TODO: is there a lua substitute?
    'christoomey/vim-sort-motion', -- TODO: is there a lua substitute?
    {
        'aserowy/tmux.nvim',
        event = 'VimEnter',
        config = function()
            return require('tmux').setup()
        end,
    },
    'brooth/far.vim',   -- TODO: is there a lua substitute?
    -- " allows opening files at specific location - e.g. /tmp/bal:10:2
    'wsdjeg/vim-fetch', -- TODO: is there a lua substitute?
    -- " Plug 'henrik/vim-open-url'
    -- 'romainl/vim-cool',
    -- " better encryption plugin - dependencies: https://github.com/jedisct1/encpipe
    'hauleth/vim-encpipe', -- TODO: is there a lua substitute?
    -- " floating windows
    -- 'machakann/vim-highlightedyank',
    'voldikss/vim-floaterm', -- TODO: is there a lua substitute?
    -- edit JIRA issues in vim
    -- 'n0v1c3/vira0,
    -- 'dddelispt42/vira', { 'do': './install.sh', }
    -- 'n0v1c3/vira',
    -- " automatically set the root directory
    'airblade/vim-rooter', -- TODO: is there a lua substitute?
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
    },
    {
        'nvim-orgmode/orgmode',
    },
    -- { 'michaelb/sniprun', build = 'bash ./install.sh' },
    'dhruvasagar/vim-table-mode', -- TODO: is there a lua substitute?
    'rest-nvim/rest.nvim',
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
    defaults = { lazy = false },
})
