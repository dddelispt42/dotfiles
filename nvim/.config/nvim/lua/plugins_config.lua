-- luacheck: globals vim
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
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
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
    {
        'folke/trouble.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {
                auto_open = true, -- automatically open the list when you have diagnostics
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
            'ray-x/cmp-treesitter',
            'rcarriga/cmp-dap',
            'saadparwaiz1/cmp_luasnip',
            -- "pontusk/cmp-vimwiki-tags"
            -- 'nyngwang/cmp-codeium',
        },
    },
    'rafamadriz/friendly-snippets',
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        -- lazy = false,
        -- event = 'VimEnter',
        event = 'VeryLazy',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
    },
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
    },
    {
        'nvim-treesitter/completion-treesitter',
        build = function()
            vim.cmd [[TSUpdate]]
        end,
    },
    'aklt/plantuml-syntax', -- TODO: check if TS syntax exists
    -- 'Sol-Ponz/plantuml-previewer.nvim',
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
    'tpope/vim-sleuth', -- TODO: is there a lua substitute?
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
                space_char_blankline = ' ',
                show_trailing_blankline_indent = true,
            }
        end,
    },
    'tpope/vim-surround', -- Surround text objects easily
    'TimUntersberger/neogit',
    'lewis6991/gitsigns.nvim',
    'akinsho/git-conflict.nvim',
    'tpope/vim-fugitive', -- TODO: is there a lua substitute?
    'tpope/vim-rhubarb', -- required by fugitive to :Gbrowse
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
    'tpope/vim-repeat', -- TODO: is there a lua substitute?
    'tpope/vim-unimpaired', -- TODO: is there a lua substitute?
    'tpope/vim-speeddating', -- TODO: is there a lua substitute?
    {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require('hop').setup {
                keys = 'etovxqpdygfblzhckisuran',
                -- multi_window = true,
            }
        end,
    },
    {
        'folke/which-key.nvim',
        config = true,
    },
    -- " Plug 'mjbrownie/hackertyper.vim'
    'will133/vim-dirdiff', -- TODO: is there a lua substitute?
    'christoomey/vim-conflicted', -- TODO: is there a lua substitute?
    'christoomey/vim-sort-motion', -- TODO: is there a lua substitute?
    {
        'aserowy/tmux.nvim',
        event = 'VimEnter',
        config = function()
            return require('tmux').setup()
        end,
    },
    'brooth/far.vim', -- TODO: is there a lua substitute?
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
    {
        'nvim-neorg/neorg',
        ft = 'norg',
        build = ':Neorg sync-parsers', -- This is the important bit!
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        'nvim-orgmode/orgmode',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('orgmode').setup_ts_grammar()
            require('orgmode').setup()
        end,
        -- event = 'BufEnter *.org',
        -- event = 'VimEnter',
    },
    { 'michaelb/sniprun', build = 'bash ./install.sh' },
    'dhruvasagar/vim-table-mode', -- TODO: is there a lua substitute?
    'rest-nvim/rest.nvim',
    -- Remove the `use` here if you're using folke/lazy.nvim.
    -- {
    --     'Exafunction/codeium.vim',
    --     event = 'VimEnter',
    --     -- config = function()
    --     --     -- Change '<C-g>' here to any keycode you like.
    --     --     vim.keymap.set('i', '<C-g>', function()
    --     --         return vim.fn['codeium#Accept']()
    --     --     end, { expr = true })
    --     -- end,
    -- },
}, {
    defaults = { lazy = false },
})
