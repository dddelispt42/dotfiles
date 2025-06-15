return {
  {
    "Pocco81/auto-save.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("auto-save").setup({
        enabled = true,
        -- execution_message = {
        --     -- message = function() -- message to print on save
        --     --     return ('AutoSave: saved at ' .. vim.fn.strftime '%H:%M:%S')
        --     -- end,
        --     message = "",
        --     dim = 0.18, -- dim the color of `message`
        --     cleaning_interval = 250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
        -- },
        debounce_delay = 1000,
      })
    end,
  },
}
