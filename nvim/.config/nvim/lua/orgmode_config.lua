-- luacheck: globals vim
local neorg_ok, neorg = pcall(require, "neorg")
if not neorg_ok then
	return
end

-- local orgbullets_ok, orgbullets = pcall(require, 'org-bullets')
-- if not orgbullets_ok then
--   return
-- end

local orgmode_ok, orgmode = pcall(require, "orgmode")
if not orgmode_ok then
	return
end

orgmode.setup_ts_grammar()

-- orgbullets.setup()

orgmode.setup({
	org_todo_keywords = { "TODO(t)", "WAITING(w)", "DELEGATED(s)", "|", "DONE(d)", "REJECTED(r)" },
	-- org_agenda_files = { '~/Sync/work/notes/*', '~/Sync/work/notes/**/*.org' },
	org_agenda_files = { "~/Sync/work/notes/**/*.org" },
	org_default_notes_file = "~/notes/capture.org",
	org_capture_templates = {
		t = {
			description = "Todo",
			template = "* TODO %? :%n:\n %U",
		},
		d = {
			description = "Delegated task",
			template = "* DELEGATED %? :who:\n %U",
		},
		m = {
			description = "Meeting",
			template = "** MEETING %u %? :%n:\n %U\n*** Participants: \n*** Agenda:\n   - \n*** Notes:\n   - \n",
			-- target = "~/notes/meetings.org",
		},
		j = {
			description = "Journal",
			template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
			-- target = "~/notes/journal.org",
		},
	},
	mappings = {
		global = {
			org_agenda = { "gA", "<Leader>oa" },
			org_capture = { "gC", "<Leader>oc" },
		},
	},
})

-- TODO: remove this if switched to orgmode completely
neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.highlights"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
					home = "~/notes/home",
				},
			},
		},
		["core.norg.journal"] = {},
		["core.norg.concealer"] = {},
		["core.norg.qol.toc"] = {},
		["core.norg.qol.todo_items"] = {
			config = { task_cycle = "<S-Space>" },
		},
		["core.syntax"] = {},
		["core.tangle"] = {},
		["core.norg.completion"] = {
			config = { engine = "nvim-cmp" },
		},
		["core.export"] = {},
		["core.export.markdown"] = {},
		["core.presenter"] = {
			config = { zen_mode = "zen-mode" },
		},
		["core.integrations.treesitter"] = {},
		["core.norg.esupports.metagen"] = {},
	},
})
