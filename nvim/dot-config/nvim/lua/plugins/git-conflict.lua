return {
  {
    "akinsho/git-conflict.nvim",
    config = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffText",
        current = "DiffAdd",
      },
    },
    keys = {
      { "n", "<leader>co", mode = { "n" }, "<Plug>(git-conflict-ours)" },
      { "n", "<leader>ct", mode = { "n" }, "<Plug>(git-conflict-theirs)" },
      { "n", "<leader>cb", mode = { "n" }, "<Plug>(git-conflict-both)" },
      { "n", "<leader>c0", mode = { "n" }, "<Plug>(git-conflict-none)" },
      { "n", "[c", mode = { "n" }, "<Plug>(git-conflict-prev-conflict)" },
      { "n", "]c", mode = { "n" }, "<Plug>(git-conflict-next-conflict)" },
    },
  },
}
