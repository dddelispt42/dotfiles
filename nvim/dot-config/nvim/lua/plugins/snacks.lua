return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Dashboard (replaces alpha-nvim)
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },

      -- Word highlighting (replaces vim-illuminate)
      words = {
        enabled = true,
        debounce = 200,
      },

      -- Indent guides (replaces indent-blankline)
      indent = {
        enabled = true,
        indent = {
          only_scope = true,
          priority = 0,
        },
        chunk = {
          enabled = true,
          priority = 0,
        },
        blank = {
          enabled = false,
        },
      },

      -- Notifications (replaces noice.nvim notification part)
      notifier = {
        enabled = true,
        timeout = 3000,
      },

      -- Startup profiler (replaces vim-startuptime)
      profiler = {
        enabled = true,
      },
    },
  },

  -- Disable noice.nvim (using snacks.notifier instead)
  {
    "folke/noice.nvim",
    enabled = false,
  },

  -- Disable nvim-lint (LazyVim core — using LSP + none-ls diagnostics instead)
  {
    "mfussenegger/nvim-lint",
    enabled = false,
  },

  -- Keep todo-comments.nvim (not replaced — no good snacks equivalent)
  -- Keep neoconf.nvim (not replaced — no snacks equivalent)
}