-- luacheck: globals vim

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	return
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- Global setup.
cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expandable() then
		-- 		luasnip.expand()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif check_backspace() then
		-- 		fallback()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- This concatonates the icons with the name of the item kind
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
			vim_item.menu = ({
				-- luasnip = "[Snippet]",
				ultisnips = "[Snippet]",
				-- treesitter = "[Treesitter]",
				-- buffer = "[Buffer]",
				path = "[Path]",
				crates = "[Crates]",
				-- spell = "[Spell]",
				emoji = "[Emoji]",
				-- emoji = "[Nvim lua]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'snippy' }, -- For snippy users.
		{ name = "ultisnips" }, -- For ultisnips users.
		-- { name = "treesitter" },
		-- { name = "buffer" },
		{ name = "neorg" },
		{ name = "path" },
		{ name = "crates" },
		{ name = "dap" },
		-- { name = "spell" },
		{ name = "emoji" },
		-- { name = "vimwiki-tags" },
		{ name = "nvim_lua" },
	}),
	-- nvim-cmp by defaults disables autocomplete for prompt buffers
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
})
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require('lspconfig').setup {
--     capabilities = capabilities
-- }
