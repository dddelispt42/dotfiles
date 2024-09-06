---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables, mixed_table)

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
        event = 'VeryLazy',
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
        -- Lazy load firenvim
        -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
        lazy = not vim.g.started_by_firenvim,
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
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
            'jayp0521/mason-nvim-dap.nvim',
            -- 'simrat39/rust-toolu.nvim',
            {
                'mrcjkb/rustaceanvim',
                version = '^5', -- Recommended
                lazy = false, -- This plugin is already lazy
            },
        },
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'nvimdev/lspsaga.nvim',
        event = 'LspAttach',
        config = function()
            require('lspsaga').setup {}
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons', -- optional
        },
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'LostNeophyte/null-ls-embedded',
            'nvimtools/none-ls-extras.nvim',
        },
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
        -- config = function()
        --     require("your.null-ls.config") -- require your null-ls config here (example below)
        -- end,
    },
    {
        'Weissle/persistent-breakpoints.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'saecki/crates.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        event = { 'BufRead Cargo.toml' },
    },
    {
        'b0o/schemastore.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'folke/trouble.nvim',
        opts = {
            auto_close = true, -- auto close when there are no items
            auto_open = true, -- auto open when there are items
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>xs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>xl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
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
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = 'make install_jsregexp',
        event = 'InsertEnter',
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
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
        'chrisgrieser/nvim-various-textobjs',
        lazy = false,
        opts = { useDefaultKeymaps = true },
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
        ft = 'plantuml',
    },
    'MTDL9/vim-log-highlighting', -- TODO: is there a lua substitute?
    -- 'Sol-Ponz/plantuml-previewer.nvim',
    {
        'javiorfo/nvim-soil',
        ft = 'plantuml',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'stevearc/aerial.nvim',
        lazy = true,
        opts = {
            filter_kind = {
                -- "Array",
                -- "Boolean",
                'Class',
                'Constant',
                'Constructor',
                'Enum',
                -- "EnumMember",
                'Event',
                'Field',
                'File',
                'Function',
                'Interface',
                -- "Key",
                'Method',
                'Module',
                'Namespace',
                -- "Null",
                -- "Number",
                'Object',
                -- "Operator",
                'Package',
                'Property',
                -- "String",
                'Struct',
                -- "TypeParameter",
                -- "Variable",
            },
        },
        -- Optional dependencies
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
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
    -- {
    --     'numToStr/Comment.nvim',
    --     config = true,
    --     keys = {
    --         {
    --             'gcc',
    --             mode = { 'n' },
    --             function()
    --                 require('Comment').toggle()
    --             end,
    --             desc = 'Comment',
    --         },
    --         {
    --             'gc',
    --             mode = { 'v' },
    --             function()
    --                 require('Comment').toggle()
    --             end,
    --             desc = 'Comment',
    --         },
    --     },
    -- },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
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
        event = { 'BufReadPre', 'BufNewFile' },
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
                        ['t'] = 'type', -- Change just the tag type
                        ['T'] = 'whole', -- Change the whole tag contents
                    },
                    aliases = {
                        ['a'] = '>', -- Single character aliases apply everywhere
                        ['b'] = ')',
                        ['B'] = '}',
                        ['r'] = ']',
                        -- Table aliases only apply for changes/deletions
                        ['q'] = { '"', "'", '`' }, -- Any quote character
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
        keys = { '<space>j', '<space>J' },
        config = function()
            require('treesj').setup {
                -- Use default keymaps
                -- (<space>m - toggle, <space>j - join, <space>s - split)
                -- use_default_keymaps = true,
                use_default_keymaps = false,

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
            -- For default preset
            vim.keymap.set('n', '<leader>j', require('treesj').toggle, { noremap = true, silent = true, desc = '[J]oin line toggle - syntax aware' })
            -- For extending default preset with `recursive = true`
            vim.keymap.set('n', '<leader>J', function()
                require('treesj').toggle { split = { recursive = true } }
            end, { noremap = true, silent = true, desc = '[J]oin line toggle - syntax aware' })
        end,
    },
    {
        'NeogitOrg/neogit',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'akinsho/git-conflict.nvim',
        config = true,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    -- {
    --     'tpope/vim-fugitive', -- TODO: is there a lua substitute?
    --     cmd = 'Git',
    -- },
    {
        'ThePrimeagen/refactoring.nvim',
        event = 'LspAttach',
    },
    {
        'SuperBo/fugit2.nvim',
        opts = {
            width = 70,
            external_diffview = true, -- tell fugit2 to use diffview.nvim instead of builtin implementation.
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            {
                'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
                dependencies = { 'stevearc/dressing.nvim' },
            },
        },
        cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
        keys = {
            { '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' },
        },
    },
    {
        'sindrets/diffview.nvim',
        cmd = {
            'DiffviewOpen',
            'DiffviewClose',
            'DiffviewToggleFiles',
            'DiffviewFocusFiles',
            'DiffviewRefresh',
            'DiffviewFileHistory',
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'yamatsum/nvim-cursorline',
        event = 'VeryLazy',
    },
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
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
        cmd = 'DirDiff',
    },
    -- 'christoomey/vim-conflicted',  -- TODO: is there a lua substitute?
    {
        'christoomey/vim-sort-motion', -- TODO: is there a lua substitute?
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'aserowy/tmux.nvim',
        event = function()
            if vim.fn.exists '$TMUX' == 1 then
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
    -- " better encryption plugin - dependencies: https://github.com/jedisct1/encpipe
    -- 'hauleth/vim-encpipe', -- TODO: is there a lua substitute?
    -- " floating windows
    -- 'machakann/vim-highlightedyank',
    {
        'voldikss/vim-floaterm', -- TODO: is there a lua substitute?
        event = 'VeryLazy',
    },
    {
        'dddelispt42/gui-font-resize.nvim',
        config = function()
            return require('gui-font-resize').setup { default_size = 10, change_by = 1, bounds = { maximum = 20 } }
        end,
    },
    -- edit JIRA issues in vim
    -- 'n0v1c3/vira0,
    -- 'dddelispt42/vira', { 'do': './install.sh', }
    -- 'n0v1c3/vira',
    -- " automatically set the root directory
    {
        'airblade/vim-rooter', -- TODO: is there a lua substitute?
        event = 'VeryLazy',
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
        cmd = 'Notifications',
    },
    {
        'nvim-orgmode/orgmode',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            {
                'chipsenkbeil/org-roam.nvim',
                'akinsho/org-bullets.nvim',
            },
        },
    },
    -- {
    --     'lukas-reineke/headlines.nvim',
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     dependencies = 'nvim-treesitter/nvim-treesitter',
    --     config = true, -- or `opts = {}`
    -- },
    -- { 'michaelb/sniprun', build = 'bash ./install.sh' },
    -- {
    --     'rest-nvim/rest.nvim',
    --     ft = 'http',
    --     dependencies = {
    --         {
    --             {
    --                 'vhyrro/luarocks.nvim',
    --                 priority = 1000,
    --                 config = true,
    --                 opts = {
    --                     rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
    --                 },
    --             },
    --         },
    --     },
    --     config = function()
    --         require('rest-nvim').setup()
    --     end,
    -- },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        -- opts = {},
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify',
        },
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
    -- {
    --     'jackMort/ChatGPT.nvim',
    --     event = 'VeryLazy',
    --     config = function()
    --         require('chatgpt').setup {
    --             -- optional configuration
    --             popup_input = {
    --                 submit = '<M-Enter>',
    --             },
    --         }
    --     end,
    --     dependencies = {
    --         'MunifTanjim/nui.nvim',
    --         'nvim-lua/plenary.nvim',
    --         'nvim-telescope/telescope.nvim',
    --     },
    -- },
    -- Custom Parameters (with defaults)
    {
        'David-Kunz/gen.nvim',
        opts = {
            model = 'llama3', -- The default model to use.
            host = 'ollama', -- The host running the Ollama service
            port = '11434', -- The port on which the Ollama service is listening.
            quit_map = 'q', -- set keymap for close the response window
            retry_map = '<c-r>', -- set keymap to re-send the current prompt
            init = function(options)
                pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
            end,
            -- Function to initialize Ollama
            command = function(options)
                local body = { model = options.model, stream = true }
                return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
            end,
            -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
            -- This can also be a command string.
            -- The executed command must return a JSON object with { response, context }
            -- (context property is optional).
            -- list_models = '<omitted lua function>', -- Retrieves a list of model names
            display_mode = 'split', -- The display mode. Can be "float" or "split".
            show_prompt = true, -- Shows the prompt submitted to Ollama.
            show_model = true, -- Displays which model you are using at the beginning of your chat session.
            no_auto_close = false, -- Never closes the window automatically.
            debug = false, -- Prints errors and the command which is run.
        },
    },
    {
        'Pocco81/auto-save.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('auto-save').setup {
                enabled = true,
                -- execution_message = {
                --     -- message = function() -- message to print on save
                --     --     return ('AutoSave: saved at ' .. vim.fn.strftime '%H:%M:%S')
                --     -- end,
                --     message = "",
                --     dim = 0.18, -- dim the color of `message`
                --     cleaning_interval = 250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
                -- },
                debounce_delay = 1000,
            }
        end,
    },
    { 'nvim-focus/focus.nvim', version = false, config = true, lazy = true },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
}, {
    -- defaults = { lazy = false },
    -- defaults = { lazy = true },
    -- ui = {
    --   icons = {
    --     ft = "",
    --     lazy = "󰂠 ",
    --     loaded = "",
    --     not_loaded = "",
    --   },
    -- },
    cache = {
        enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    performance = {
        rtp = {
            reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                '2html_plugin',
                'black',
                'bugreport',
                'compiler',
                'editorconfig',
                'filetype',
                'ftplugin',
                'fzf',
                'getscript',
                'getscriptPlugin',
                'gzip',
                'logipat',
                'man',
                'matchit',
                'netrw',
                'netrwFileHandlers',
                'netrwPlugin',
                'netrwSettings',
                'optwin',
                'rplugin',
                'rrhelper',
                'skim',
                'json',
                'spellfile_plugin',
                'synmenu',
                'syntax',
                'tar',
                'tarPlugin',
                'tohtml',
                'tutor',
                'vimball',
                'vimballPlugin',
                'zip',
                'zipPlugin',
            },
        },
    },
})
