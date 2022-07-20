-- luacheck: globals vim

require("sidebar-nvim").setup({
	disable_default_keybindings = 0,
	bindings = nil,
	open = false,
	side = "right",
	initial_width = 35,
	hide_statusline = false,
	update_interval = 1000,
	sections = {
		"datetime",
		"git",
		"symbols",
		"todos",
		"diagnostics",
		require("dap-sidebar-nvim.breakpoints"),
		"buffers",
	},
	section_separator = { "", "-----", "" },
	containers = {
		attach_shell = "/bin/sh",
		show_all = true,
		interval = 5000,
	},
	datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
	todos = {
		icon = "",
		-- ignore certain paths, this will prevent huge folders like $HOME to hog Neovim with TODO searching
		ignored_paths = { "~" },
		-- whether the groups should be initially closed on start. You can manually open/close groups later.
		initially_closed = false,
	},
	dap = {
		breakpoints = {
			icon = "🔍",
		},
	},
})
local lualine_ok, lualine = pcall(require, "lualine")
if lualine_ok then
	lualine.setup()
end
