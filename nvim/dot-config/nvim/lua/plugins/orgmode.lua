return {
  {
    "nvim-orgmode/orgmode",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "chipsenkbeil/org-roam.nvim",
        "akinsho/org-bullets.nvim",
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
      org_deadline_warning_days = 14,
      org_agenda_span = "day",
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
              org_agenda_span = "day", -- can be any value as org_agenda_span
            },
            {
              type = "tags_todo",
              -- match = 'work', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "My unplanned todos",
              org_agenda_todo_ignore_scheduled = "all", -- Ignore all headlines that are scheduled. Possible values: past | future | all
            },
            -- {
            --     type = 'agenda',
            --     org_agenda_overriding_header = 'Whole week overview',
            --     org_agenda_span = 'week', -- 'week' is default, so it's not necessary here, just an example
            --     -- org_agenda_start_on_weekday = 1, -- Start on Monday
            --     org_agenda_remove_tags = true, -- Do not show tags only for this view
            -- },
          },
        },
        w = {
          description = "Personal agenda",
          types = {
            {
              type = "tags_todo",
              match = '+PRIORITY="1"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "My work todos",
              org_agenda_category_filter_preset = "work", -- Show only headlines from `todos` category. Same value providad as when pressing `/` in the Agenda view
              org_agenda_sorting_strategy = { "todo-state-up", "priority-down" }, -- See all options available on org_agenda_sorting_strategy
            },
            {
              type = "agenda",
              match = "work", --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Work projects agenda",
            },
            {
              type = "tags",
              match = "work", --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Work projects unplanned",
              org_agenda_todo_ignore_scheduled = "all", -- Ignore all headlines that are scheduled. Possible values: past | future | all
            },
          },
        },
        h = {
          description = "Personal agenda",
          types = {
            {
              type = "tags_todo",
              org_agenda_overriding_header = "My personal todos",
              org_agenda_category_filter_preset = "home", -- Show only headlines from `todos` category. Same value providad as when pressing `/` in the Agenda view
              org_agenda_sorting_strategy = { "todo-state-up", "priority-down" }, -- See all options available on org_agenda_sorting_strategy
            },
            {
              type = "agenda",
              match = "work", --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Personal projects agenda",
            },
            {
              type = "tags",
              match = "home", --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Personal projects notes",
              org_agenda_todo_ignore_scheduled = "all", -- Ignore all headlines that are scheduled. Possible values: past | future | all
            },
          },
        },
        b = {
          description = "Business agenda",
          types = {
            {
              type = "tags_todo",
              match = '+PRIORITY="1"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "My business todos",
              org_agenda_category_filter_preset = "busi", -- Show only headlines from `todos` category. Same value providad as when pressing `/` in the Agenda view
              org_agenda_sorting_strategy = { "todo-state-up", "priority-down" }, -- See all options available on org_agenda_sorting_strategy
            },
            {
              type = "agenda",
              match = "busi", --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Business projects agenda",
            },
            {
              type = "tags",
              match = "busi", --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
              org_agenda_overriding_header = "Business projects notes",
              org_agenda_todo_ignore_scheduled = "all", -- Ignore all headlines that are scheduled. Possible values: past | future | all
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
          template = "* TODO [#5] %?  [0/1]  :%n:home:\n %U SCHEDULED: %t\n   :PROPERTIES:\n   :CATEGORY: home\n   :Effort: 0:30\n   :END:",
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
          org_toggle_checkbox = { "g<space>", "<c-space>" },
          -- org_capture = { 'gC', '<Leader>oc' },
        },
      },
    },
  },
}
