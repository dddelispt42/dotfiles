-- luacheck: globals vim
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- the packet manager for nvim
    use 'wbthomason/packer.nvim'
    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
    -- use "mhinz/vim-startify"
    -- use "dstein64/vim-startuptime"
    use 'norcalli/nvim-colorizer.lua'
    use 'folke/zen-mode.nvim'
    use {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](0)
        end,
    }
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup {}
        end,
    }
    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        },
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jayp0521/mason-null-ls.nvim'
    use { 'LostNeophyte/null-ls-embedded' }
    use 'jayp0521/mason-nvim-dap.nvim'
    -- use 'glepnir/lspsaga.nvim'
    -- use 'wbthomason/lsp-status.nvim'
    -- use 'nvim-lua/lsp_extensions.nvim'
    use 'simrat39/rust-tools.nvim'
    use {
        'saecki/crates.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
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
    }
    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
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
    }
    use 'rafamadriz/friendly-snippets'
    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }
    use 'nvim-treesitter/playground'
    use {
        'nvim-treesitter/completion-treesitter',
        run = function()
            vim.cmd [[TSUpdate]]
        end,
    }
    use 'aklt/plantuml-syntax'
    -- use("Sol-Ponz/plantuml-previewer.nvim")
    use 'sidebar-nvim/sidebar.nvim'
    use 'sidebar-nvim/sections-dap'
    use 'mfussenegger/nvim-dap'
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
    use 'mfussenegger/nvim-dap-python'
    use 'nvim-telescope/telescope-dap.nvim'
    use {
        'theHamsta/nvim-dap-virtual-text',
        run = function()
            vim.g.dap_virtual_text = true
        end,
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }
    use 'tpope/vim-sleuth'
    use {
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
    }
    use 'tpope/vim-surround' -- Surround text objects easily
    use 'TimUntersberger/neogit'
    use 'lewis6991/gitsigns.nvim'
    use 'akinsho/git-conflict.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb' -- required by fugitive to :Gbrowse
    use 'ThePrimeagen/refactoring.nvim'
    use 'sindrets/diffview.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use 'yamatsum/nvim-cursorline'
    use 'ellisonleao/gruvbox.nvim'
    -- use({
    -- 	"akinsho/bufferline.nvim",
    -- 	requires = "kyazdani42/nvim-web-devicons",
    -- 	config = function()
    -- 		require("bufferline").setup({})
    -- 	end,
    -- })
    use 'romgrk/barbar.nvim'
    -- " interesting but not yet configured
    -- " Git commit browser (:GV)
    -- Plug 'junegunn/gv.vim'
    -- " works with tabular to format markdown tables when pressing "|"
    -- " todo: fix Plug 'quentindecock/vim-cucumber-align-pipes'
    -- " immediate preview
    -- " Vimwiki - http://thedarnedestthing.com/vimwiki%20cheatsheet
    -- " Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
    use 'vimwiki/vimwiki'
    -- " Latex
    -- " Plug 'vim-latex/vim-latex', { 'for': 'tex' }
    -- " Plug 'lervag/vimtex'
    -- use 'donRaphaco/neotex'
    -- use 'benmills/vimux'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-speeddating'
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
        end,
    }
    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    }
    -- " Plug 'mjbrownie/hackertyper.vim'
    use 'will133/vim-dirdiff'
    use 'christoomey/vim-conflicted'
    use 'christoomey/vim-sort-motion'
    use {
        'aserowy/tmux.nvim',
        config = function()
            require('tmux').setup()
        end,
    }
    use 'brooth/far.vim'
    -- " allows opening files at specific location - e.g. /tmp/bal:10:2
    use 'wsdjeg/vim-fetch'
    -- " Plug 'henrik/vim-open-url'
    -- use 'romainl/vim-cool'
    -- " better encryption plugin - requires: https://github.com/jedisct1/encpipe
    use 'hauleth/vim-encpipe'
    -- " floating windows
    -- use 'machakann/vim-highlightedyank'
    use 'voldikss/vim-floaterm'
    -- edit JIRA issues in vim
    -- use "n0v1c3/vira"
    -- use 'dddelispt42/vira', { 'do': './install.sh' }
    use 'n0v1c3/vira'
    -- " automatically set the root directory
    use 'airblade/vim-rooter'
    -- use "github/copilot.vim"
    use {
        'nvim-neorg/neorg',
        run = ':Neorg sync-parsers', -- This is the important bit!
        -- after = "nvim-treesitter", -- You may want to specify Telescope here as well
        requires = 'nvim-lua/plenary.nvim',
        -- ft = 'norg',
    }
    use 'nvim-orgmode/orgmode'
    -- use 'akinsho/org-bullets.nvim'
    use { 'michaelb/sniprun', run = 'bash ./install.sh' }
    use 'dhruvasagar/vim-table-mode'
    -- use {
    --     'lukas-reineke/headlines.nvim',
    --     config = function()
    --         require('headlines').setup()
    --     end,
    -- }
    use 'rest-nvim/rest.nvim'

    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, 'custom.plugins')
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    -- TODO: do for plugin.lua
    pattern = vim.fn.expand '$MYVIMRC',
})
