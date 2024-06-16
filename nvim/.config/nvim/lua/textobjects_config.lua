---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local various_textobjs_ok, various_textobjs = pcall(require, 'various-textobjs')
if not various_textobjs_ok then
    vim.notify 'various-textobjs plugin not loaded!'
    return
end

vim.keymap.set("n", "gx", function()
	-- select URL
	various_textobjs.url()

	-- plugin only switches to visual mode when textobj found
	local foundURL = vim.fn.mode():find("v")
	if not foundURL then return end

	-- retrieve URL with the z-register as intermediary
	vim.cmd.normal { '"zy', bang = true }
	local url = vim.fn.getreg("z")
	vim.ui.open(url) -- requires nvim 0.10
end, { desc = "URL Opener" })

vim.keymap.set("n", "gX", function()
	various_textobjs.url()
	local foundURL = vim.fn.mode():find("v")
	if foundURL then
		vim.cmd.normal('"zy')
		local url = vim.fn.getreg("z")
		vim.ui.open(url)
	else
		-- find all URLs in buffer
		local urlPattern = require("various-textobjs.charwise-textobjs").urlPattern
		local bufText = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
		local urls = {}
		for url in bufText:gmatch(urlPattern) do
			table.insert(urls, url)
		end
		if #urls == 0 then return end

		-- select one, use a plugin like dressing.nvim for nicer UI for
		-- `vim.ui.select`
		vim.ui.select(urls, { prompt = "Select URL:" }, function(choice)
			if choice then vim.ui.open(choice) end
		end)
	end
end, { desc = "URL Opener" })

vim.keymap.set("n", "dsi", function()
	-- select outer indentation
	various_textobjs.indentation("outer", "outer")

	-- plugin only switches to visual mode when a textobj has been found
	local indentationFound = vim.fn.mode():find("V")
	if not indentationFound then return end

	-- dedent indentation
	vim.cmd.normal { "<", bang = true }

	-- delete surrounding lines
	local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
	local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
	vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
	vim.cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete Surrounding Indentation" })

vim.keymap.set("n", "ysii", function()
	local startPos = vim.api.nvim_win_get_cursor(0)

	-- identify start- and end-border
	various_textobjs.indentation("outer", "outer")
	local indentationFound = vim.fn.mode():find("V")
	if not indentationFound then return end
	vim.cmd.normal { "V", bang = true } -- leave visual mode so the `'<` `'>` marks are set

	-- copy them into the + register
	local startLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
	local endLn = vim.api.nvim_buf_get_mark(0, ">")[1] - 1
	local startLine = vim.api.nvim_buf_get_lines(0, startLn, startLn + 1, false)[1]
	local endLine = vim.api.nvim_buf_get_lines(0, endLn, endLn + 1, false)[1]
	vim.fn.setreg("+", startLine .. "\n" .. endLine .. "\n")

	-- highlight yanked text
	local ns = vim.api.nvim_create_namespace("ysi")
	vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", startLn, 0, -1)
	vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", endLn, 0, -1)
	vim.defer_fn(function() vim.api.nvim_buf_clear_namespace(0, ns, 0, -1) end, 1000)

	-- restore cursor position
	vim.api.nvim_win_set_cursor(0, startPos)
end, { desc = "Yank surrounding indentation" })
