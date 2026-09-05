return {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
  config = function()
    local tmux = require("tmux")
    tmux.setup({
      copy_sync = {
        enable = true,
        ignore_buffers = { empty = false },
        redirect_to_clipboard = true,
        register_offset = 0,
        sync_clipboard = true,
        sync_registers = true,
        sync_registers_keymap_put = true,
        sync_registers_keymap_reg = true,
        sync_deletes = true,
        sync_unnamed = true,
      },
      navigation = {
        cycle_navigation = true,
        enable_default_keybindings = true,
        persist_zoom = false,
      },
      resize = {
        enable_default_keybindings = true,
        resize_step_x = 1,
        resize_step_y = 1,
      },
      swap = {
        cycle_navigation = false,
        enable_default_keybindings = true,
      },
    })
  end,
}
