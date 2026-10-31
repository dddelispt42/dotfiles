return {
  {
    "nvim-mini/mini.nvim",
    version = "*",
    event = "VeryLazy",
    modules = {
      "mini.indentscope",
      "mini.align",
      "mini.operators",
    },
    config = function()
      -- mini.indentscope: indent guides
      require("mini.indentscope").setup({
        draw = {
          delay = 100,
          priority = 0,
        },
        symbol = "│",
      })

      -- mini.align: text alignment (tables, assignments, etc.)
      require("mini.align").setup({})

      -- mini.operators: sort text objects
      -- Press gss + motion to sort (e.g. gssip to sort paragraph, gssj to sort lines)
      -- Or in visual mode: select text, press gs to sort
      require("mini.operators").setup({
        -- Sort options
        sort = {
          -- Enable sorting via `gs` operator
          module = true,
          -- Natural number sorting (10 > 9 instead of "10" < "9")
          natural_ordering = true,
          -- Case-insensitive sorting by default
          -- Press gssi to toggle case sensitivity
          prefix = "gs",
        },
      })
    end,
  },

  -- Other mini modules are loaded via LazyVim extras as individual packages:
  -- mini.ai       → coding.coding (LazyVim extra)
  -- mini.comment  → coding.mini-comment (LazyVim extra)
  -- mini.surround → coding.mini-surround (LazyVim extra)
  -- mini.diff     → editor.mini-diff (LazyVim extra)
  -- mini.animate  → ui.mini-animate (LazyVim extra)
  -- mini.hipatterns → util.mini-hipatterns (LazyVim extra)
}
