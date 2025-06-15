return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = { "<space>j", "<space>J" },
  config = function()
    require("treesj").setup({
      -- Use default keymaps
      -- (<space>m - toggle, <space>j - join, <space>s - split)
      -- use_default_keymaps = true,
      use_default_keymaps = false,

      -- Node with syntax error will not be formatted
      check_syntax_error = true,

      -- If line after join will be longer than max value,
      -- node will not be formatted
      max_join_length = 120,

      -- hold|start|end:
      -- hold - cursor follows the node/place on which it was called
      -- start - cursor jumps to the first symbol of the node being formatted
      -- end - cursor jumps to the last symbol of the node being formatted
      cursor_behavior = "hold",

      -- Notify about possible problems or not
      notify = true,
      -- langs = langs,

      -- Use `dot` for repeat action
      dot_repeat = true,
    })
    -- For default preset
    vim.keymap.set(
      "n",
      "<leader>j",
      require("treesj").toggle,
      { noremap = true, silent = true, desc = "[J]oin line toggle - syntax aware" }
    )
    -- For extending default preset with `recursive = true`
    vim.keymap.set("n", "<leader>J", function()
      require("treesj").toggle({ split = { recursive = true } })
    end, { noremap = true, silent = true, desc = "[J]oin line toggle - syntax aware" })
  end,
}
