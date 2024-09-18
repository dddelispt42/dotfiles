---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local orgmode_ok, orgmode = pcall(require, 'orgmode')
if not orgmode_ok then
    vim.notify 'orgmode plugin not loaded!'
    return
end

-- orgmode.setup_ts_grammar()

orgmode.setup {
    org_todo_keywords = { 'TODO(t)', 'NEXT(n)', 'WAITING(w)', 'DELEGATED(s)', '|', 'DONE(d)', 'REJECTED(r)' },
    org_todo_keyword_faces = {
        TODO = ':background #000000 :foreground red :weight bold', -- overrides builtin color for keyword
        NEXT = ':background red :foreground white : weight bold',
        WAITING = ':foreground lightblue :weight bold',
        DELEGATED = ':background #FFFFFF :slant italic :underline on',
    },
    -- org_agenda_files = { '~/notes/*', '~/notes/**/*.org' },
    org_agenda_files = { '~/notes/**/*.org' },
    org_default_notes_file = '~/notes/capture.org',
    org_hide_emphasis_markers = true,
    -- org_indent_mode = 'noindent',
    org_deadline_warning_days = 3,
    org_agenda_span = 'week',
    -- org_agenda_start_day = '-1d',
    org_priority_highest = 0,
    org_priority_default = 7,
    org_priority_lowest = 9,
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_capture_templates = {
        t = 'TODO',
        tw = {
            description = 'Todo - WORK',
            template = '* TODO [#5] %? :%n:work:\n %U\n   :PROPERTIES:\n   :CATEGORY: work\n   :Effort: 0:30\n   :END:',
            target = '~/notes/capture.org',
        },
        th = {
            description = 'Todo - HOME',
            template = '* TODO [#5] %? :%n:home:\n %U\n   :PROPERTIES:\n   :CATEGORY: home\n   :Effort: 0:30\n   :END:',
            target = '~/notes/capture.org',
        },
        d = {
            description = 'Delegated task',
            template = '* DELEGATED [#5] %? :who:\n %U\n   :PROPERTIES:\n   :CATEGORY: work\n   :Effort: 0:10\n   :END:',
            target = '~/notes/capture.org',
        },
        m = {
            description = 'Meeting',
            template = '** MEETING %u %? :%n:\n %U\n*** Participants: \n*** Agenda:\n   - \n*** Notes:\n   - \n',
            -- target = "~/notes/meetings.org",
            target = '~/notes/capture.org',
        },
        j = {
            description = 'Journal',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            target = '~/notes/journal.org',
        },
    },
    mappings = {
        global = {
            org_agenda = { 'gA', '<Leader>oa' },
            -- org_capture = { 'gC', '<Leader>oc' },
        },
    },
}
local orgroam_ok, orgroam = pcall(require, 'org-roam')
if not orgroam_ok then
    vim.notify 'org-roam plugin not loaded!'
    return
end
orgroam.setup {
    directory = '~/notes/roam',
}

local orgbullets_ok, orgbullets = pcall(require, 'org-bullets')
if not orgbullets_ok then
    vim.notify 'org-bullets plugin not loaded!'
    return
end
orgbullets.setup()
