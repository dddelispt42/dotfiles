-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    -- TODO: Maybe handle windows better?
    if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    local out =
        vim.fn.system(
        string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    print("Downloading packer.nvim...")
    print("( You'll need to restart now )")

    return
end

return require("packer").startup {
    function(use)
        use "wbthomason/packer.nvim"

        local local_use = function(first, second)
            local plug_path, home
            if second == nil then
                plug_path = first
                home = "heiko"
            else
                plug_path = second
                home = first
            end

            if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
                use("~/plugins/" .. plug_path)
            else
                use(string.format("%s/%s", home, plug_path))
            end
        end

        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }
        -- use {
        --     "nvim-telescope/telescope-frecency.nvim",
        --     config = function()
        --         require"telescope".load_extension("frecency")
        --     end,
        --     requires = {"tami5/sqlite.lua"}
        -- }

        -- use "mhinz/vim-startify"
        use "dstein64/vim-startuptime"
        use "norcalli/nvim-colorizer.lua"
        -- use "norcalli/nvim-terminal.lua"
        use {
            "glacambre/firenvim",
            run = function()
                vim.fn["firenvim#install"](0)
            end
        }
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icon
            },
            config = function() require'nvim-tree'.setup {} end
        }
        --LSP
        use "neovim/nvim-lspconfig"
        use "glepnir/lspsaga.nvim"
        use "wbthomason/lsp-status.nvim"
        use "nvim-lua/lsp_extensions.nvim"
        use "RishabhRD/nvim-lsputils"
        use "anott03/nvim-lspinstall"
        -- use "kosayoda/nvim-lightbulb"
        -- use "mfussenegger/nvim-jdtls"
        -- TODO: switch to trouble - only keep one
        use "kevinhwang91/nvim-bqf"
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end
        }
        -- TODO: switch to nvim-ls
        use "w0rp/ale"
        use "onsails/lspkind-nvim"
        use "ray-x/lsp_signature.nvim"
        -- use "metakirby5/codi.vim"
        -- Extentions to built-in LSP, for example, providing type inlay hints
        -- Autocompletion framework for built-in LSP
        -- use 'nvim-lua/completion-nvim'
        -- TODO: switch to cmp
        use "hrsh7th/nvim-compe" -- deprecated
        -- use "hrsh7th/nvim-cmp"
        -- use "hrsh7th/cmp-buffer"
        -- use "hrsh7th/cmp-path"
        -- use "hrsh7th/cmp-nvim_lua"
        -- use "hrsh7th/cmp-nvim_lsp"
        -- use "saadparwaiz1/cmp-luasnip"
        -- use 'hrsh7th/vim-vsnip'
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                vim.cmd [[TSUpdate]]
            end
        }
        use {
            "nvim-treesitter/completion-treesitter",
            run = function()
                vim.cmd [[TSUpdate]]
            end
        }
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        -- use {
        --     "lewis6991/spellsitter.nvim",
        --     config = function()
        --         require("spellsitter").setup {
        --             hl = "SpellBad",
        --             captures = {} -- set to {} to spellcheck everything
        --         }
        --     end
        -- }
        use "SirVer/ultisnips"
        -- use 'norcalli/snippets.nvim'
        -- use "liuchengxu/vista.vim"
        use 'sidebar-nvim/sidebar.nvim'
        use "mfussenegger/nvim-dap"
        use "mfussenegger/nvim-dap-python"
        use "nvim-telescope/telescope-dap.nvim"
        use {
            "theHamsta/nvim-dap-virtual-text",
            run = function()
                vim.g.dap_virtual_text = true
            end
        }
        -- use "nvim-treesitter/playground"
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require('indent_blankline').setup {
                    show_current_context = true,
                    show_current_context_start = true,
                    show_end_of_line = true,
                    space_char_blankline = " ",
                }
            end
        }
        use "tpope/vim-surround" -- Surround text objects easily
        -- Floating windows are awesome :)
        -- used <leader>gm to see the related git commit msg
        use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
        use "rhysd/git-messenger.vim"
        use 'sindrets/diffview.nvim'
        -- use {"junegunn/fzf", run = "./install --all"} -- Fuzzy Searcher
        -- use {"junegunn/fzf.vim"}
        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = function()
                require("lualine").setup {
                    options = {
                        theme = "gruvbox",
                        section_separators = {"", ""},
                        component_separators = {"", ""},
                        icons_enabled = true
                    },
                    sections = {
                        lualine_a = {{"mode", upper = true}},
                        lualine_b = {{"branch", icon = ""}},
                        lualine_c = {{"filename", file_status = true}},
                        lualine_x = {"encoding", "fileformat", "filetype"},
                        lualine_y = {"progress"},
                        lualine_z = {"location"}
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = {"filename"},
                        lualine_x = {"location"},
                        lualine_y = {},
                        lualine_z = {}
                    },
                    extensions = {"fzf"}
                }
            end
        }
        -- TODO: substitute with gitsigns
        use "tpope/vim-fugitive"
        use "airblade/vim-gitgutter"
        use "tpope/vim-rhubarb" -- required by fugitive to :Gbrowse
        use "ellisonleao/gruvbox.nvim"
        use "ntpeters/vim-better-whitespace"
        use "aklt/plantuml-syntax"
        -- " Plug 'sjurgemeyer/vim-plantuml', { 'for': 'plantuml' }
        use "nathanalderson/yang.vim"
        -- use 'bling/vim-bufferline'
        use "romgrk/barbar.nvim"
        -- " interesting but not yet configured
        -- " Git commit browser (:GV)
        -- Plug 'junegunn/gv.vim'
        -- " works with tabular to format markdown tables when pressing "|"
        -- " todo: fix Plug 'quentindecock/vim-cucumber-align-pipes'
        -- " immediate preview
        -- " Vimwiki - http://thedarnedestthing.com/vimwiki%20cheatsheet
        -- " Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
        use "vimwiki/vimwiki"
        -- " Latex
        -- " Plug 'vim-latex/vim-latex', { 'for': 'tex' }
        -- " Plug 'lervag/vimtex'
        use "donRaphaco/neotex"
        use "benmills/vimux"
        use "tpope/vim-repeat"
        use "tpope/vim-unimpaired"
        use "tpope/vim-speeddating"
        use {
            'phaazon/hop.nvim',
            branch = 'v1', -- optional but strongly recommended
            config = function()
                -- you can configure Hop the way you like here; see :h hop-config
                require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
            end
        }
        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end
        }
        -- " Plug 'mjbrownie/hackertyper.vim'
        use "will133/vim-dirdiff"
        use "christoomey/vim-conflicted"
        use "christoomey/vim-sort-motion"
        use "christoomey/vim-tmux-navigator"
        use "brooth/far.vim"
        -- " allows opening files at specific location - e.g. /tmp/bal:10:2
        use 'wsdjeg/vim-fetch'
        -- " Plug 'henrik/vim-open-url'
        use "romainl/vim-cool"
        -- " better encryption plugin - requires: https://github.com/jedisct1/encpipe
        use "hauleth/vim-encpipe"
        -- " floating windows
        use "machakann/vim-highlightedyank"
        use "voldikss/vim-floaterm"
        -- edit JIRA issues in vim
        -- use "n0v1c3/vira"
        -- use 'dddelispt42/vira', { 'do': './install.sh' }
        -- " automatically set the root directory
        use "airblade/vim-rooter"
        -- use "github/copilot.vim"
    end,
    config = {
        _display = {
            open_fn = function(name)
                -- Can only use plenary when we have our plugins.
                --  We can only get plenary when we don't have our plugins ;)
                local ok, float_win =
                    pcall(
                    function()
                        return require("plenary.window.float").percentage_range_window(0.8, 0.8)
                    end
                )

                if not ok then
                    vim.cmd [[65vnew  [packer] ]]

                    return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
                end

                local bufnr = float_win.bufnr
                local win = float_win.win_id

                vim.api.nvim_buf_set_name(bufnr, name)
                vim.api.nvim_win_set_option(win, "winblend", 10)

                return win, bufnr
            end
        }
    }
}
