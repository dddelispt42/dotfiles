-- luacheck: globals vim
local tele_ok, tele = pcall(require, 'telescope')
if not tele_ok then
  return
end

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
tele.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- tele.setup({
-- 	defaults = {
-- 		vimgrep_arguments = {
-- 			"rg",
-- 			"-uu",
-- 			"--color=never",
-- 			"--no-heading",
-- 			"--with-filename",
-- 			"--line-number",
-- 			"--column",
-- 			"--smart-case",
-- 		},
-- 		prompt_prefix = "> ",
-- 		selection_caret = "> ",
-- 		entry_prefix = "  ",
-- 		initial_mode = "insert",
-- 		selection_strategy = "reset",
-- 		sorting_strategy = "descending",
-- 		layout_strategy = "horizontal",
-- 		layout_config = {
-- 			horizontal = {
-- 				mirror = false,
-- 			},
-- 			vertical = {
-- 				mirror = false,
-- 			},
-- 		},
-- 		file_sorter = require("telescope.sorters").get_fuzzy_file,
-- 		file_ignore_patterns = {},
-- 		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
-- 		winblend = 0,
-- 		border = {},
-- 		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
-- 		color_devicons = true,
-- 		use_less = true,
-- 		path_display = {},
-- 		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
-- 		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
-- 		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
-- 		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--
-- 		-- Developer configurations: Not meant for general override
-- 		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
-- 	},
-- })
-- require("telescope").load_extension("fzf")
