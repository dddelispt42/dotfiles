return {
  "cordx56/rustowl",
  version = "*", -- Latest stable version
  build = "cargo binstall rustowl",
  lazy = false, -- This plugin is already lazy
  opts = {
    auto_attach = true, -- Auto attach the RustOwl LSP client when opening a Rust file
    auto_enable = true, -- Enable RustOwl immediately when attaching the LSP client
    idle_time = 500, -- Time in milliseconds to hover with the cursor before triggering RustOwl
    client = {}, -- LSP client configuration that gets passed to `vim.lsp.start`
    highlight_style = "undercurl", -- You can also use 'underline'
  },
}
