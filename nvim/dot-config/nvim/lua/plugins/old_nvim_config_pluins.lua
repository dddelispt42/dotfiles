return {
  -- { -- Autocompletion
  --     'hrsh7th/nvim-cmp',
  --     event = 'InsertEnter',
  --     dependencies = {
  --         'f3fora/cmp-spell',
  --         'hrsh7th/cmp-buffer',
  --         'hrsh7th/cmp-cmdline',
  --         'hrsh7th/cmp-emoji',
  --         'hrsh7th/cmp-nvim-lsp',
  --         'hrsh7th/cmp-nvim-lua',
  --         'hrsh7th/cmp-path',
  --         'hrsh7th/cmp-nvim-lsp-signature-help',
  --         'ray-x/cmp-treesitter',
  --         'rcarriga/cmp-dap',
  --         'saadparwaiz1/cmp_luasnip',
  --         -- "pontusk/cmp-vimwiki-tags"
  --     },
  -- },
  -- {
  --     'L3MON4D3/LuaSnip',
  --     dependencies = { 'rafamadriz/friendly-snippets' },
  --     build = 'make install_jsregexp',
  --     event = 'InsertEnter',
  -- },
  -- { -- Highlight, edit, and navigate code
  --     'nvim-treesitter/nvim-treesitter',
  --     build = ':TSUpdate',
  --     event = { 'BufReadPre', 'BufNewFile' },
  --     dependencies = {
  --         'nvim-treesitter/nvim-treesitter-refactor',
  --         'nvim-treesitter/nvim-treesitter-context',
  --         'nvim-treesitter/nvim-treesitter-textobjects',
  --         'RRethy/nvim-treesitter-endwise',
  --         'RRethy/nvim-treesitter-textsubjects',
  --         'windwp/nvim-ts-autotag',
  --     },
  -- },
  -- {
  --     'chrisgrieser/nvim-various-textobjs',
  --     lazy = false,
  --     -- opts = { useDefaultKeymaps = true },
  -- },
  -- {
  --     'nvim-treesitter/completion-treesitter',
  --     build = function()
  --         vim.cmd [[TSUpdate]]
  --     end,
  --     event = { 'BufReadPre', 'BufNewFile' },
  -- },
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  -- Useful status updates for LSP
  "j-hui/fidget.nvim",
  -- Additional lua configuration, makes nvim stuff amazing
  "folke/neodev.nvim",
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "LostNeophyte/null-ls-embedded",
      "nvimtools/none-ls-extras.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    -- config = function()
    --     require("your.null-ls.config") -- require your null-ls config here (example below)
    -- end,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({})
    end,
    event = "VeryLazy",
  },
  {
    "dddelispt42/gui-font-resize.nvim",
    config = function()
      return require("gui-font-resize").setup({ default_size = 10, change_by = 1, bounds = { maximum = 20 } })
    end,
  },
  {
    "tversteeg/registers.nvim",
    event = "VeryLazy",
    config = function()
      local registers = require("registers")
      registers.setup({})
    end,
  },
  { "nvim-focus/focus.nvim", version = false, config = true, lazy = true },
}
