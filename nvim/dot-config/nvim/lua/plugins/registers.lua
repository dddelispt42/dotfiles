return {
  "tversteeg/registers.nvim",
  event = "VeryLazy",
  config = function()
    local registers = require("registers")
    registers.setup({})
  end,
}
