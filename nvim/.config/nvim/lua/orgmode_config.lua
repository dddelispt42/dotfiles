-- luacheck: globals vim
local neorg_ok, neorg = pcall(require, 'neorg')
if not neorg_ok then
    return
end

local orgbullets_ok, orgbullets = pcall(require, 'org-bullets')
if not orgbullets_ok then
    return
end

local orgmode_ok, orgmode = pcall(require, 'orgmode')
if not orgmode_ok then
    return
end

orgmode.setup_ts_grammar()

orgbullets.setup()

orgmode.setup {
    org_todo_keywords = { 'TODO(t)', 'NEXT(n)', 'WAITING(w)', 'DELEGATED(s)', '|', 'DONE(d)', 'REJECTED(r)' },
    org_todo_keyword_faces = {
        TODO = ':background #000000 :foreground red :weight bold', -- overrides builtin color for `TODO` keyword
        NEXT = ':background red :foreground white : weight bold',
        WAITING = ':foreground lightblue :weight bold',
        DELEGATED = ':background #FFFFFF :slant italic :underline on',
    },
    -- org_agenda_files = { '~/Sync/work/notes/*', '~/Sync/work/notes/**/*.org' },
    org_agenda_files = { '~/Sync/work/notes/**/*.org' },
    org_default_notes_file = '~/notes/capture.org',
    org_hide_emphasis_markers = true,
    org_indent_mode = 'noindent',
    org_deadline_warning_days = 3,
    org_agenda_span = 'day',
    org_agenda_start_day = '-1d',
    org_priority_highest = 1,
    org_priority_default = 5,
    org_priority_lowest = 9,
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_capture_templates = {
        t = 'TODO',
        tw = {
            description = 'Todo - WORK',
            template = '* TODO [#5] %? :%n:work:\n %U\n   :PROPERTIES:\n   :CATEGORY: work\n   :END:',
        },
        th = {
            description = 'Todo - HOME',
            template = '* TODO [#5] %? :%n:work:\n %U\n   :PROPERTIES:\n   :CATEGORY: home\n   :END:',
        },
        d = {
            description = 'Delegated task',
            template = '* DELEGATED [#5] %? :who:\n %U\n   :PROPERTIES:\n   :CATEGORY: work\n   :END:',
        },
        m = {
            description = 'Meeting',
            template = '** MEETING %u %? :%n:\n %U\n*** Participants: \n*** Agenda:\n   - \n*** Notes:\n   - \n',
            -- target = "~/notes/meetings.org",
        },
        j = {
            description = 'Journal',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            -- target = "~/notes/journal.org",
        },
    },
    mappings = {
        global = {
            org_agenda = { 'gA', '<Leader>oa' },
            -- org_capture = { 'gC', '<Leader>oc' },
        },
    },
}

-- TODO: remove this if switched to orgmode completely
neorg.setup {
    load = {
        ['core.defaults'] = {},
        ['core.highlights'] = {},
        ['core.norg.dirman'] = {
            config = {
                workspaces = {
                    work = '~/notes/work',
                    home = '~/notes/home',
                },
            },
        },
        ['core.norg.journal'] = {},
        ['core.norg.concealer'] = {},
        ['core.norg.qol.toc'] = {},
        ['core.norg.qol.todo_items'] = {
            config = { task_cycle = '<S-Space>' },
        },
        ['core.syntax'] = {},
        ['core.tangle'] = {},
        ['core.norg.completion'] = {
            config = { engine = 'nvim-cmp' },
        },
        ['core.export'] = {},
        ['core.export.markdown'] = {},
        ['core.presenter'] = {
            config = { zen_mode = 'zen-mode' },
        },
        ['core.integrations.treesitter'] = {},
        ['core.norg.esupports.metagen'] = {},
    },
}
