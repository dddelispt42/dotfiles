-- luacheck: globals vim
local masondap_ok, masondap = pcall(require, 'mason-nvim-dap')
if not masondap_ok then
  return
end
local nvimdap_ok, nvimdap = pcall(require, 'dap')
if not nvimdap_ok then
  return
end
masondap.setup {
  -- A list of adapters to install if they're not already installed.
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = { 'bask', 'codelldb', 'python' },

  -- NOTE: this is left here for future porting in case needed
  -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Daps are not automatically installed.
  --   - true: All adapters set up via dap are automatically installed.
  --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones
  --                            provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "python", "delve" } }
  automatic_installation = true,

  -- Whether adapters that are installed in mason should be automatically set up in dap.
  -- Removes the need to set up dap manually.
  -- See mappings.adapters and mappings.configurations for settings.
  -- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
  -- Can either be:
  -- 	- false: Dap is not automatically configured.
  -- 	- true: Dap is automatically configured.
  -- 	- {adapters: {ADAPTER: {}, }, configurations: {ADAPTER: {}, }}. Allows overriding default configuration.
  automatic_setup = false,
}
-- masondap.setup_handlers {
--   function(source_name)
--     -- all sources with no handler get passed here
--
--     -- Keep original functionality of `automatic_setup = true`
--     require 'mason-nvim-dap.automatic_setup'(source_name)
--   end,
--   python = function(source_name)
--     nvimdap.adapters.python = {
--       type = 'executable',
--       command = '/usr/bin/python3',
--       args = {
--         '-m',
--         'debugpy.adapter',
--       },
--     }
--
--     nvimdap.configurations.python = {
--       {
--         type = 'python',
--         request = 'launch',
--         name = 'Launch file',
--         program = '${file}', -- This configuration will launch the current file if used.
--       },
--     }
--   end,
-- }

local dapui_ok, dapui = pcall(require, 'dapui')
if not dapui_ok then
  return
end
dapui.setup {
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has 'nvim-0.7',
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = 'scopes', size = 0.25 },
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40, -- 40 columns
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 0.25, -- 25% of total lines
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = 'single', -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
}

nvimdap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
nvimdap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
nvimdap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

local dapvtext_ok, dapvtext = pcall(require, 'nvim-dap-virtual-text')
if not dapvtext_ok then
  return
end
dapvtext.setup {
  -- enable this plugin (the default)
  enabled = true,
  -- create commands DapVirtualTextEnable, DapVirtualTextDisable,
  -- DapVirtualTextToggle, (DapVirtualTextForceRefresh for
  -- refreshing when debug adapter did not notify its termination)
  enabled_commands = true,
  -- highlight changed values with NvimDapVirtualTextChanged,
  -- else always NvimDapVirtualText
  highlight_changed_variables = true,
  -- highlight new variables in the same way as changed variables
  -- (if highlight_changed_variables)
  highlight_new_as_changed = true,
  -- show stop reason when stopped for exceptions
  show_stop_reason = true,
  -- prefix virtual text with comment string
  commented = true,
  -- only show virtual text at first definition (if there are multiple)
  only_first_definition = true,
  -- show virtual text on all all references of the variable
  -- (not only definitions)
  all_references = false,
  -- filter references (not definitions) pattern when all_references
  -- is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  filter_references_pattern = '<module',
  -- position of virtual text, see `:h nvim_buf_set_extmark()`
  virt_text_pos = 'eol',
  -- show virtual text for all stack frames not only current.
  -- Only works for debugpy on my machine.
  all_frames = false,
  -- show virtual lines instead of virtual text (will flicker!)
  virt_lines = false,
  -- position the virtual text at a fixed window column
  -- (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
  virt_text_win_col = nil,
}
