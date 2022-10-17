version = "0.19.4"

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
  .. ";"
  .. xpm_path
  .. "/?.lua;"
  .. xpm_path
  .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require("xpm").setup({
  plugins = {
    -- Let xpm manage itself
    'dtomvan/xpm.xplr',
    'sayanarijit/fzf.xplr',
    'prncss-xyz/icons.xplr',
    'sayanarijit/zoxide.xplr',
    'sayanarijit/xargs.xplr',
    'sayanarijit/dual-pane.xplr',
    'sayanarijit/trash-cli.xplr',
    -- 'sayanarijit/preview-tabbed.xplr',
    'sayanarijit/dragon.xplr',
    'sayanarijit/scp.xplr',
    'sayanarijit/xclip.xplr',
    { 'dtomvan/extra-icons.xplr',
      after = function()
          xplr.config.general.table.row.cols[2] = { format = "custom.icons_dtomvan_col_1" }
      end
    },
    -- 'sayanarijit/regex-search.xplr',
    'sayanarijit/tri-pane.xplr',
    'sayanarijit/dua-cli.xplr',
    'sayanarijit/map.xplr',
    'sayanarijit/command-mode.xplr',
  },
  auto_install = true,
  auto_cleanup = true,
})

require("fzf").setup{
  mode = "default",
  key = "ctrl-f",
  -- args = "--preview 'pistol {}'"
}

require"icons".setup()

require("zoxide").setup{
  mode = "default",
  key = "Z",
}

require("xargs").setup{
  mode = "default",
  key = "X",
  placeholder = "{}",
  shell = "bash",
}

require("dual-pane").setup{
  active_pane_width = { Percentage = 70 },
  inactive_pane_width = { Percentage = 30 },
}

-- Type `dd` to trash, `dr` to restore.
require("trash-cli").setup{
  trash_mode = "delete",
  trash_key = "d",
  restore_mode = "delete",
  restore_key = "r",
  trash_list_selector = "fzf -m | cut -d' ' -f3-"
}

-- Type `:p` to toggle preview mode.
-- require("preview-tabbed").setup{
--   mode = "action",
--   key = "p",
--   fifo_path = "/tmp/xplr.fifo",
--   previewer = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
-- }

-- Select files and type `:sD` to drag
-- Type `:sD` without selecting anything to drop
require("dragon").setup{
  mode = "selection_ops",
  key = "D",
  drag_args = "",
  drop_args = "",
  keep_selection = false,
  bin = "dragon",
}

-- Type `:sS` and send the selected files.
-- Make sure `~/.ssh/config` or `/etc/ssh/ssh_config` is updated.
-- Else you'll need to enter each host manually.
require("scp").setup{
  mode = "selection_ops",  -- or `xplr.config.modes.builtin.selection_ops`
  key = "S",
  scp_command = "scp -r",
  non_interactive = false,
  keep_selection = false,
}

-- Type `yy` to copy and `p` to paste whole files.
-- Type `yp` to copy the paths of focused or selected files.
-- Type `yP` to copy the parent directory path.
require("xclip").setup{
  copy_command = "xclip-copyfile",
  copy_paths_command = "xclip -sel clip",
  paste_command = "xclip-pastefile",
  keep_selection = false,
}

-- -- Type `/` and then the pattern to match
-- require("regex-search").setup{
--   mode = "default",  -- or xplr.config.modes.builtin.default
--   key = "/",  -- or xplr.config.modes.builtin.default.key_bindings.on_key["/"]
--   prompt = "/",
--   initial_input = "(?i)^",
-- }

require("tri-pane").setup({
  layout_key = "T", -- In switch_layout mode
  as_default_layout = true,
  left_pane_width = { Percentage = 20 },
  middle_pane_width = { Percentage = 50 },
  right_pane_width = { Percentage = 30 },
})

-- Type `:D` to spawn dua-cli in $PWD
require("dua-cli").setup{
  mode = "action",
  key = "D",
}

-- Type `M` to switch to single map mode.
-- Then press `tab` to switch between single and multi map modes.
-- Press `ctrl-o` to edit the command using your editor.
require("map").setup{
  mode = "default"  -- or `xplr.config.modes.builtin.default`,
  key = "M",
  editor = os.getenv("EDITOR") or "vim",
  editor_key = "ctrl-o",
  prefer_multi_map = false,
  placeholder = "{}",
  custom_placeholders = {
    ["{ext}"] = function(node)
      -- See https://xplr.dev/en/lua-function-calls#node
      return node.extension
    end,

    ["{name}"] = map.placeholders["{name}"]
  },
}

-- TODO: move command into own lua file
-- Type `:` to enter command mode
local m = require("command-mode")
m.setup{
  mode = "default",
  key = ":",
  remap_action_mode_to = {
    mode = "default",
    key = ";",
  }
}
-- Type `:hello-lua` and press enter to know your location
local hello_lua = m.cmd("hello-lua", "Enter name and know location")(function(app)
  print("What's your name?")

  local name = io.read()
  local greeting = "Hello " .. name .. "!"
  local message = greeting .. " You are inside " .. app.pwd

  return {
    { LogSuccess = message },
  }
end)

-- Type `:hello-bash` and press enter to know your location
local hello_bash = m.silent_cmd("hello-bash", "Enter name and know location")(
  m.BashExec [===[
    echo "What's your name?"

    read name
    greeting="Hello $name!"
    message="$greeting You are inside $PWD"

    echo LogSuccess: '"'$message'"' >> "${XPLR_PIPE_MSG_IN:?}"
  ]===]
)

-- Bind `:hello-lua` to key `h`
hello_lua.bind("default", "h")

-- Bind `:hello-bash` to key `H`
hello_bash.bind(xplr.config.modes.builtin.default, "H")
