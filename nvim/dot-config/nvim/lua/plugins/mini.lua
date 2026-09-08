return {
  {
    "nvim-mini/mini.nvim",
    version = "*",
    event = "VeryLazy",
    modules = {
      "mini.indentscope",
      "mini.align",
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
