-- luacheck: globals vim
-- TODO: check Packer code against latest in github

-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	-- TODO: Maybe handle windows better?
	if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
		return
	end

	local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

	vim.fn.mkdir(directory, "p")

	local out = vim.fn.system(
		string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
	)

	print(out)
	print("Downloading packer.nvim...")
	print("( You'll need to restart now )")

	return
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return packer.startup({
	function(use)
		use("wbthomason/packer.nvim")

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

		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		})
		-- use {
		--     "nvim-telescope/telescope-frecency.nvim",
		--     config = function()
		--         require"telescope".load_extension("frecency")
		--     end,
		--     requires = {"tami5/sqlite.lua"}
		-- }

		-- use "mhinz/vim-startify"
		-- use "dstein64/vim-startuptime"
		use("norcalli/nvim-colorizer.lua")
        use("folke/zen-mode.nvim")
		-- use "norcalli/nvim-terminal.lua"
		use({
			"glacambre/firenvim",
			run = function()
				vim.fn["firenvim#install"](0)
			end,
		})
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icon
			},
			config = function()
				require("nvim-tree").setup({})
			end,
		})
		if os.getenv("OS") ~= "Windows_NT" then
			--LSP
			use("neovim/nvim-lspconfig")
			use("glepnir/lspsaga.nvim")
			use("wbthomason/lsp-status.nvim")
			use("nvim-lua/lsp_extensions.nvim")
            use {
                "williamboman/mason.nvim",
                "jose-elias-alvarez/null-ls.nvim",
                "jayp0521/mason-null-ls.nvim",
            }
			-- TODO: configure rust plugin
			use({
				"simrat39/rust-tools.nvim",
				config = function()
					require("rust-tools").setup({})
				end,
			})
			-- TODO: configure cargo plugin
			use({
				"saecki/crates.nvim",
				requires = { "nvim-lua/plenary.nvim" },
				config = function()
					require("crates").setup()
				end,
			})
			-- use "kosayoda/nvim-lightbulb"
			use("mfussenegger/nvim-jdtls")
		end

		-- TODO: switch to trouble - only keep one
		-- use("kevinhwang91/nvim-bqf")
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					auto_open = true, -- automatically open the list when you have diagnostics
					auto_close = true, -- automatically close the list when you have no diagnostics
					-- automatically preview the location of the diagnostic.
					-- <esc> to close preview and go back to last window
					auto_preview = true,
					-- mode = "document_diagnostics",
				})
			end,
		})
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-emoji")
		use("rcarriga/cmp-dap")
		use("ray-x/cmp-treesitter")
		use("f3fora/cmp-spell")
		-- use("pontusk/cmp-vimwiki-tags")
		use("hrsh7th/nvim-cmp")
		-- For vsnip users.
		-- use 'hrsh7th/cmp-vsnip'
		-- use 'hrsh7th/vim-vsnip'
		-- For luasnip users.
		-- use 'L3MON4D3/LuaSnip'
		-- use 'saadparwaiz1/cmp_luasnip'
		-- For ultisnips users.
		use({
			"SirVer/ultisnips",
			requires = { { "honza/vim-snippets", rtp = "." } },
			config = function()
				-- vim.g.UltiSnipsSnippetsDir = "~/dev/heiko/dotfiles/vim/UltiSnips"
				vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
				-- vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
				vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
				vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
				vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
				vim.g.UltiSnipsRemoveSelectModeMappings = 0
			end,
		})
		use("quangnguyen30192/cmp-nvim-ultisnips")

		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				vim.cmd([[TSUpdate]])
			end,
		})
        use("p00f/nvim-ts-rainbow")
		use({
			"nvim-treesitter/completion-treesitter",
			run = function()
				vim.cmd([[TSUpdate]])
			end,
		})
		-- use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		-- use {
		--     "lewis6991/spellsitter.nvim",
		--     config = function()
		--         require("spellsitter").setup {
		--             hl = "SpellBad",
		--             captures = {} -- set to {} to spellcheck everything
		--         }
		--     end
		-- }
		-- use "SirVer/ultisnips"
		-- use 'norcalli/snippets.nvim'
		-- use "liuchengxu/vista.vim"
		use("sidebar-nvim/sidebar.nvim")
		use("sidebar-nvim/sections-dap")
		use("mfussenegger/nvim-dap")
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
		use("mfussenegger/nvim-dap-python")
		use("nvim-telescope/telescope-dap.nvim")
		use({
			"theHamsta/nvim-dap-virtual-text",
			run = function()
				vim.g.dap_virtual_text = true
			end,
		})
		use "nvim-treesitter/playground"
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("indent_blankline").setup({
					show_current_context = true,
					show_current_context_start = true,
					show_end_of_line = true,
					space_char_blankline = " ",
				})
			end,
		})
		use("tpope/vim-surround") -- Surround text objects easily
		use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})
		use({
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
			config = function()
				require("refactoring").setup({})
			end,
		})
		use({
			"nvim-treesitter/nvim-treesitter-context",
			requires = {
				{ "nvim-treesitter/nvim-treesitter" },
			},
			config = function()
				require("treesitter-context").setup({})
			end,
		})
		use("sindrets/diffview.nvim")
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
		-- TODO: substitute with gitsigns
		use("tpope/vim-fugitive")
		-- use "airblade/vim-gitgutter"
		use("tpope/vim-rhubarb") -- required by fugitive to :Gbrowse
		use("ellisonleao/gruvbox.nvim")
		use("ntpeters/vim-better-whitespace")
		use("aklt/plantuml-syntax")
		-- " Plug 'sjurgemeyer/vim-plantuml', { 'for': 'plantuml' }
		use("nathanalderson/yang.vim")
		-- use({
		-- 	"akinsho/bufferline.nvim",
		-- 	requires = "kyazdani42/nvim-web-devicons",
		-- 	config = function()
		-- 		require("bufferline").setup({})
		-- 	end,
		-- })
		use("romgrk/barbar.nvim")
		-- " interesting but not yet configured
		-- " Git commit browser (:GV)
		-- Plug 'junegunn/gv.vim'
		-- " works with tabular to format markdown tables when pressing "|"
		-- " todo: fix Plug 'quentindecock/vim-cucumber-align-pipes'
		-- " immediate preview
		-- " Vimwiki - http://thedarnedestthing.com/vimwiki%20cheatsheet
		-- " Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
		-- use("vimwiki/vimwiki")
		-- " Latex
		-- " Plug 'vim-latex/vim-latex', { 'for': 'tex' }
		-- " Plug 'lervag/vimtex'
		use("donRaphaco/neotex")
		use("benmills/vimux")
		use("tpope/vim-repeat")
		use("tpope/vim-unimpaired")
		use("tpope/vim-speeddating")
		use({
			"phaazon/hop.nvim",
			branch = "v1", -- optional but strongly recommended
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})
		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})
		-- " Plug 'mjbrownie/hackertyper.vim'
		use("will133/vim-dirdiff")
		use("christoomey/vim-conflicted")
		use("christoomey/vim-sort-motion")
		use("christoomey/vim-tmux-navigator")
		use("brooth/far.vim")
		-- " allows opening files at specific location - e.g. /tmp/bal:10:2
		use("wsdjeg/vim-fetch")
		-- " Plug 'henrik/vim-open-url'
		use("romainl/vim-cool")
		-- " better encryption plugin - requires: https://github.com/jedisct1/encpipe
		use("hauleth/vim-encpipe")
		-- " floating windows
		use("machakann/vim-highlightedyank")
		use("voldikss/vim-floaterm")
		-- edit JIRA issues in vim
		-- use "n0v1c3/vira"
		-- use 'dddelispt42/vira', { 'do': './install.sh' }
		use("n0v1c3/vira")
		-- " automatically set the root directory
		use("airblade/vim-rooter")
		-- use "github/copilot.vim"
        use {
            "nvim-neorg/neorg",
            run = ":Neorg sync-parsers", -- This is the important bit!
            -- after = "nvim-treesitter", -- You may want to specify Telescope here as well
            requires = "nvim-lua/plenary.nvim",
            -- ft = 'norg',
        }
        -- use {'nvim-orgmode/orgmode', config = function()
        --     require('orgmode').setup{}
        --     end
        -- }
        use('akinsho/org-bullets.nvim')
        use { 'michaelb/sniprun', run = 'bash ./install.sh'}
        use('dhruvasagar/vim-table-mode')
        use {
            'lukas-reineke/headlines.nvim',
            config = function()
                require('headlines').setup()
            end,
        }
	end,
	config = {
		_display = {
			open_fn = function(name)
				-- Can only use plenary when we have our plugins.
				--  We can only get plenary when we don't have our plugins ;)
				local ok, float_win = pcall(function()
					return require("plenary.window.float").percentage_range_window(0.8, 0.8)
				end)

				if not ok then
					vim.cmd([[65vnew  [packer] ]])

					return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
				end

				local bufnr = float_win.bufnr
				local win = float_win.win_id

				vim.api.nvim_buf_set_name(bufnr, name)
				vim.api.nvim_win_set_option(win, "winblend", 10)

				return win, bufnr
			end,
		},
	},
})
