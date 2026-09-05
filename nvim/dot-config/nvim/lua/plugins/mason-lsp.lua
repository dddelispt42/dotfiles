return {
  -- Auto-install LSP servers, formatters, and linters via Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "ty",
        "gopls",
        "typescript-language-server",
        "tailwindcss-language-server",
        "yamlls",
        "jsonls",
        "clangd",
        "cmake-language-server",
        "jdtls",
        "helm_ls",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "ansible-language-server",
        "nil",
        "nushell",
        "sqlls",
        "texlab",
        "ziggy",
        "angular-language-server",

        -- Linters / spell check
        "typos-lsp",

        -- Formatters
        "stylua",
        "shfmt",
        "prettier",
        "goimports",
        "gofumpt",

        -- Linters
        "shellcheck",
        "eslint_d",
      },
      auto_update = true,
      run_on_start = true,
    },
  },

  -- Useful status updates for LSP
  "j-hui/fidget.nvim",

  -- Enhanced Rust LSP experience
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}