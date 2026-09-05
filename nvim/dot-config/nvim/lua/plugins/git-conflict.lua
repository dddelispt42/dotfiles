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
      { "n", "<leader>cO", mode = { "n" }, "<Plug>(git-conflict-ours)", desc = "[c]onflict [O]urs" },
      { "n", "<leader>cT", mode = { "n" }, "<Plug>(git-conflict-theirs)", desc = "[c]onflict [T]heirs" },
      { "n", "<leader>cB", mode = { "n" }, "<Plug>(git-conflict-both)", desc = "[c]onflict [B]oth" },
      { "n", "<leader>c0", mode = { "n" }, "<Plug>(git-conflict-none)", desc = "[c]onflict n[0]ne" },
      { "n", "[c", mode = { "n" }, "<Plug>(git-conflict-prev-conflict)", desc = "[c]onflict [p]rev" },
      { "n", "]c", mode = { "n" }, "<Plug>(git-conflict-next-conflict)", desc = "[c]onflict [n]ext" },
    },
  },
}
