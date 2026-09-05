return {
  -- LSP server configurations for additional tools
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- ty: Astral Python type checker
        -- Only provides diagnostics, no completions/hover
        ty = {
          enabled = true,
          settings = {
            python = {
              pythonPath = vim.fn.executable("python3") == 1 and "python3" or "python",
            },
          },
        },
        -- typos-lsp: Source code spell checker for all file types
        ["typos-lsp"] = {
          enabled = true,
          init_options = {
            -- Only check comments and strings, not code identifiers
            diagnosticSeverity = "Hint",
          },
        },
        -- pylyzer: Rust-based Python type checker (installed but disabled by default)
        pylyzer = {
          enabled = false, -- Enable via :LspStart pylyzer if needed
        },
        -- pyre: Meta's Python type checker (installed but disabled by default)
        pyre = {
          enabled = false, -- Enable via :LspStart pyre if needed
        },
      },
      setup = {
        -- Ensure ty only provides diagnostics, not completions/navigation
        ty = function(_, client)
          if client.server_capabilities then
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.definitionProvider = false
            client.server_capabilities.referencesProvider = false
            client.server_capabilities.completionProvider = nil
          end
        end,
        -- typos-lsp: ensure it runs on all file types
        ["typos-lsp"] = function()
          -- LazyVim's lspconfig setup handles this automatically
        end,
      },
    },
  },
}