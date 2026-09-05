return {
  {
    "saghen/blink.cmp",
    -- Override LazyVim's default blink config
    opts = {
      keymap = {
        -- Traditional keybindings (no super-tab)
        preset = "none",
        ["<C-y>"] = { "select_and_accept" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-space>"] = { "show", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },

        -- Snippet navigation inside placeholders
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      sources = {
        default = { "lsp", "snippets", "path", "buffer", "dadbod", "omni" },
        providers = {
          -- LSP completions
          lsp = {
            name = "LSP",
            enabled = true,
            score_offset = 100,
          },
          -- Snippet completions (from luasnip / friendly-snippets)
          snippets = {
            name = "Snippets",
            enabled = true,
            score_offset = 80,
          },
          -- File path completions
          path = {
            name = "Path",
            enabled = true,
            score_offset = 60,
          },
          -- Buffer word completions
          buffer = {
            name = "Buffer",
            enabled = true,
            score_offset = 40,
            opts = {
              min_keyword_length = 3,
            },
          },
          -- vim-dadbod SQL completions
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
            enabled = true,
            score_offset = 90,
          },
          -- Omni completion for plugins with custom completefunc (orgmode, vimtex, etc.)
          omni = {
            name = "Omni",
            enabled = true,
            score_offset = 50,
          },
        },
      },

      -- Don't show completion while typing in certain contexts
      disabled = {
        filetypes = function(ctx)
          return vim.tbl_contains({
            "TelescopePrompt",
            "alpha",
            "Avante",
            "AvanteInput",
            "log",
            "qf",
            "noice",
            "NeogitCommit",
            "NeogitLogView",
            "help",
          }, vim.bo[ctx.buf].filetype)
        end,
      },

      completion = {
        -- Show documentation window automatically
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        -- Show the menu when typing
        menu = {
          auto_show = true,
          border = "rounded",
        },
      },
    },
  },
}