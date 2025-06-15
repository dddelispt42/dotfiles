return {
  {
    "dddelispt42/gui-font-resize.nvim",
    config = function()
      return require("gui-font-resize").setup({ default_size = 10, change_by = 1, bounds = { maximum = 20 } })
    end,
  },
}
