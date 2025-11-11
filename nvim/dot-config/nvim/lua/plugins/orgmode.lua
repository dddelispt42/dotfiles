return {
  {
    "nvim-orgmode/orgmode",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        {
          "chipsenkbeil/org-roam.nvim",
          config = function()
            require("org-roam").setup({
              directory = "~/notes/roam/",
              bindings = {
                prefix = "<Leader>N",
              },
            })
          end,
        },
        -- "akinsho/org-bullets.nvim",
      },
    },
    opts = {
      org_todo_keywords = { "TODO(t)", "NEXT(n)", "WAITING(w)", "DELEGATED(s)", "|", "DONE(d)", "REJECTED(r)" },
      org_todo_keyword_faces = {
        TODO = ":background #000000 :foreground red :weight bold", -- overrides builtin color for keyword
        NEXT = ":background red :foreground white : weight bold",
        WAITING = ":foreground lightblue :weight bold",
        DELEGATED = ":background #FFFFFF :slant italic :underline on",
      },
      -- org_agenda_files = { '~/notes/*', '~/notes/**/*.org' },
      org_agenda_files = { "~/notes/**/*.org" },
      org_default_notes_file = "~/notes/capture.org",
      -- org_hide_emphasis_markers = true,
      -- org_indent_mode = 'noindent',
      org_deadline_warning_days = 7,
      org_agenda_span = "week",
      org_log_repeat = false,
      calendar_week_start_day = 1,
      -- org_agenda_start_day = '-1d',
      org_priority_highest = 0,
      org_priority_default = 7,
      org_priority_lowest = 9,
      org_startup_folded = "content",
      -- org_agenda_skip_scheduled_if_done = true,
      -- org_agenda_skip_deadline_if_done = true,
      org_agenda_custom_commands = {
        -- "c" is the shortcut that will be used in the prompt
        c = {
          description = "Combined view", -- Description shown in the prompt for the shortcut
          types = {
            {
              type = "tags_todo", -- Type can be agenda | tags | tags_todo
              match = '+PRIORITY="1"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "High priority todos",
              org_agenda_todo_ignore_deadlines = "far", -- Ignore all deadlines that are too far in future (over org_deadline_warning_days). Possible values: all | near | far | past | future
              org_agenda_todo_ignore_scheduled = "future", -- Ignore all headlines that are scheduled. Possible values: past | future | all
            },
            {
              type = "agenda",
              org_agenda_overriding_header = "My daily agenda",
              org_agenda_span = "week", -- can be any value as org_agenda_span
            },
            {
              type = "tags_todo",
              -- match = 'work', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "My unplanned todos",
              org_agenda_todo_ignore_scheduled = "all", -- Ignore all headlines that are scheduled. Possible values: past | future | all
            },
          },
        },
        d = {
          description = "Deadlines view", -- Description shown in the prompt for the shortcut
          types = {
            {
              type = "tags_todo", -- Type can be agenda | tags | tags_todo
              match = 'PRIORITY="1"|PRIORITY="2"|PRIORITY="3"|PRIORITY="4"|PRIORITY="5"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Without Deadline - High Prio",
              org_agenda_todo_ignore_deadlines = "future", -- Ignore all deadlines that are too far in future (over org_deadline_warning_days). Possible values: all | near | far | past | future
            },
            {
              type = "tags_todo", -- Type can be agenda | tags | tags_todo
              match = 'PRIORITY="6"|PRIORITY="7"|PRIORITY="8"|PRIORITY="9"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Without Deadline - Low Prio",
              org_agenda_todo_ignore_deadlines = "future", -- Ignore all deadlines that are too far in future (over org_deadline_warning_days). Possible values: all | near | far | past | future
            },
          },
        },
      },
      org_capture_templates = {
        t = "TODO",
        tw = {
          description = "Todo - WORK",
          template = "* TODO [#5] %?  [0/1]  :%n:work:\n %U SCHEDULED: %t\n   :PROPERTIES:\n   :CATEGORY: work\n   :Effort: 1:00\n   :END:",
          target = "~/notes/capture.org",
        },
        th = {
          description = "Todo - HOME",
          template = "* TODO [#5] %?  [0/1]  :%n:home:\n %U SCHEDULED: %t\n   :PROPERTIES:\n   :CATEGORY: home\n   :Effort: 1:00\n   :END:",
          target = "~/notes/capture.org",
        },
        tb = {
          description = "Todo - BUSINESS",
          template = "* TODO [#5] %?  [0/1]  :%n:business:\n %U SCHEDULED: %t\n   :PROPERTIES:\n   :CATEGORY: business\n   :Effort: 1:30\n   :END:",
          target = "~/notes/capture.org",
        },
        d = {
          description = "Delegated task",
          template = "* DELEGATED [#5] %?  [0/1]  :who:\n %U SCHEDULED: %t\n   :PROPERTIES:\n   :CATEGORY: work\n   :Effort: 0:10\n   :END:",
          target = "~/notes/capture.org",
        },
        m = {
          description = "Meeting",
          template = "** MEETING %u %? :%n:\n %U\n*** Participants: \n*** Agenda:\n   - \n*** Notes:\n   - \n",
          -- target = "~/notes/meetings.org",
          target = "~/notes/capture.org",
        },
        j = {
          description = "Journal",
          template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
          target = "~/notes/journal.org",
        },
      },
      mappings = {
        global = {
          -- org_agenda = { "gA", "<Leader>oac" },
          org_toggle_checkbox = { "<Leader>X" },
          -- org_capture = { 'gC', '<Leader>oc' },
        },
      },
    },
  },
}
