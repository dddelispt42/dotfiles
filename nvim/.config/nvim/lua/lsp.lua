-- local lsp_status = require("lsp-status")
-- completion_customize_lsp_label as used in completion-nvim
-- Optional: customize the kind labels used in identifying the current function.
-- g:completion_customize_lsp_label is a dict mapping from LSP symbol kind
-- to the string you want to display as a label
-- lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

local lsp_installer = require("nvim-lsp-installer")
local nvim_lsp = require("lspconfig")

-- function to attach completion when setting up lsp
local on_attach = function(client)
	-- was needed for completion-nvim
	-- require'completion'.on_attach(client)
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- nvim_lsp.setup({
--     capabilities = capabilities
-- })

-- Enable rust_analyzer
-- nvim_lsp.pyls.setup({on_attach = on_attach, capabilities = capabilities})
-- nvim_lsp.bashls.setup({on_attach = on_attach, capabilities = capabilities})
nvim_lsp.ccls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.dockerls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.html.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.vimls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.yamlls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.jdtls.setup({ on_attach = on_attach, capabilities = capabilities })

-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
-- require("jdtls").start_or_attach(
--   -- {cmd = {"java-lsp.sh"}, root_dir = require("jdtls.setup").find_root({"gradle.build", "pom.xml"})}
--   {cmd = {"java-lsp.sh"}}
-- )

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = true,
})

local saga = require("lspsaga")

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- error_header = "  Error",
-- warn_header = "  Warn",
-- hint_header = "  Hint",
-- infor_header = "  Infor",
-- max_diag_msg_width = 50,
-- code_action_icon = ' ',
-- code_action_keys = { quit = 'q',exec = '<CR>' }
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border | 4: ascii border
-- border_style = 1
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

saga.init_lsp_saga({})

-- or --use default config
saga.init_lsp_saga()

require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-uu",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
})
-- require("telescope").load_extension("fzf")

-- require'lsp_signature'.on_attach()

local neogit = require("neogit")
neogit.setup({})
