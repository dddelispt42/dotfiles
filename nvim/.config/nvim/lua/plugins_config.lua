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
--
-- Define leader key
vim.g.mapleader = ',' -- 'vim.g' sets global variables
vim.g.maplocalleader = ','

require('lazy').setup {
    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    'norcalli/nvim-colorizer.lua',
    'folke/zen-mode.nvim',
    {
        'glacambre/firenvim',
        build = function()
            vim.fn['firenvim#install'](0)
        end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup {}
        end,
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
    -- 'glepnir/lspsaga.nvim',
    -- 'wbthomason/lsp-status.nvim',
    -- 'nvim-lua/lsp_extensions.nvim',
    'simrat39/rust-tools.nvim',
    {
        'saecki/crates.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
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
        },
    },
    'rafamadriz/friendly-snippets',
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
    },
    'nvim-treesitter/playground',
    {
        'nvim-treesitter/completion-treesitter',
        build = function()
            vim.cmd [[TSUpdate]]
        end,
    },
    'aklt/plantuml-syntax',
    -- 'Sol-Ponz/plantuml-previewer.nvim',
    'sidebar-nvim/sidebar.nvim',
    'sidebar-nvim/sections-dap',
    'mfussenegger/nvim-dap',
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
        config = function()
            require('Comment').setup()
        end,
    },
    'tpope/vim-sleuth',
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
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb', -- required by fugitive to :Gbrowse
    'ThePrimeagen/refactoring.nvim',
    'sindrets/diffview.nvim',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
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
    -- {
    -- 	"akinsho/bufferline.nvim",
    -- 	dependencies = "kyazdani42/nvim-web-devicons",
    -- 	config = function()
    -- 		require("bufferline").setup({})
    -- 	end,
    -- },
    'romgrk/barbar.nvim',
    {
        'vimwiki/vimwiki',
        ft = 'vimwiki',
    },
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-speeddating',
    {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
        end,
    },
    {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    },
    -- " Plug 'mjbrownie/hackertyper.vim'
    'will133/vim-dirdiff',
    'christoomey/vim-conflicted',
    'christoomey/vim-sort-motion',
    {
        'aserowy/tmux.nvim',
        config = function()
            require('tmux').setup()
        end,
    },
    'brooth/far.vim',
    -- " allows opening files at specific location - e.g. /tmp/bal:10:2
    'wsdjeg/vim-fetch',
    -- " Plug 'henrik/vim-open-url'
    -- 'romainl/vim-cool',
    -- " better encryption plugin - dependencies: https://github.com/jedisct1/encpipe
    'hauleth/vim-encpipe',
    -- " floating windows
    -- 'machakann/vim-highlightedyank',
    'voldikss/vim-floaterm',
    -- edit JIRA issues in vim
    -- 'n0v1c3/vira0,
    -- 'dddelispt42/vira', { 'do': './install.sh', }
    -- 'n0v1c3/vira',
    -- " automatically set the root directory
    'airblade/vim-rooter',
    -- 'github/copilot.vim',
    {
        'nvim-neorg/neorg',
        ft = 'norg',
        build = ':Neorg sync-parsers', -- This is the important bit!
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        'nvim-orgmode/orgmode',
        ft = 'org',
    },
    { 'michaelb/sniprun', build = 'bash ./install.sh' },
    'dhruvasagar/vim-table-mode',
    'rest-nvim/rest.nvim',
    -- Remove the `use` here if you're using folke/lazy.nvim.
    {
        'Exafunction/codeium.vim',
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function()
                return vim.fn['codeium#Accept']()
            end, { expr = true })
        end,
    },
}
