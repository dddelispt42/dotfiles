return {
  {
    "folke/snacks.nvim",
    opts = {
      autosave = {
        enabled = true,
        debounce = 1000,
        notify = false,
        events = { "InsertLeave", "TextChanged" },
      },
    },
  },
}