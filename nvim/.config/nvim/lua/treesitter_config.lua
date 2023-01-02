-- luacheck: globals vim
local ts_ok, ts = pcall(require, 'nvim-treesitter.configs')
if not ts_ok then
  return
end

-- vim.api.nvim_exec(
--     [[
--     set foldmethod=expr
--     set foldexpr=nvim_treesitter#foldexpr()
--     ]],
--     false
-- )

ts.setup {
  -- A list of parser names, or "all"
  -- ensure_installed = {"c", "lua", "rust", "norg"},
  ensure_installed = 'all',

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'gnn',
      scope_incremental = 'gnc',
      node_decremental = 'gnd',
    },
  },
  -- indent = {
  --   enable = true,
  -- },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}
