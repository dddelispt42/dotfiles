-- luacheck: globals vim
---@diagnostic disable: undefined-global

local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
    return
end

mason.setup {
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
}

local nvim_lsp = require 'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    -- was needed for completion-nvim
    -- require'completion'.on_attach(client)
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- nvim_lsp.setup({
--     capabilities = capabilities
-- })

-- Enable rust_analyzer
-- nvim_lsp.ccls.setup({ on_attach = on_attach, capabilities = capabilities })
-- nvim_lsp.pyls.setup({on_attach = on_attach, capabilities = capabilities})
-- nvim_lsp.spectral.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.angularls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.ansiblels.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.bashls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.bufls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.clangd.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.cssls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.diagnosticls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.dockerls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.gopls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.gradle_ls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.groovyls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.helm_ls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.html.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.jdtls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.jsonls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.julials.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.lemminx.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.lua_ls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.mutt_ls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.nil_ls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.nimls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.ocamllsp.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.openscad_lsp.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.pyright.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.ruff_lsp.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.rust_analyzer.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.sqlls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.taplo.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.tsserver.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.vimls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.zls.setup { on_attach = on_attach, capabilities = capabilities }
nvim_lsp.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
            },
            schemas = require('schemastore').yaml.schemas {
                ignore = {
                    '.eslintrc',
                },
            },
            -- TODO: add schema for mappings
            extra = {
                {
                    description = 'My custom JSON schema',
                    fileMatch = 'foo.json',
                    name = 'foo.json',
                    url = 'https://example.com/schema/foo.json',
                },
                {
                    description = 'My other custom JSON schema',
                    fileMatch = { 'bar.json', '.baar.json' },
                    name = 'bar.json',
                    url = 'https://example.com/schema/bar.json',
                },
            },
        },
    },
}
nvim_lsp.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
            },
            schemas = require('schemastore').yaml.schemas {
                ignore = {
                    '.eslintrc',
                },
            },
        },
    },
}

-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
-- require("jdtls").start_or_attach(
--   -- {cmd = {"java-lsp.sh"}, root_dir = require("jdtls.setup").find_root({"gradle.build", "pom.xml"})}
--   {cmd = {"java-lsp.sh"}}
-- )

-- Enable diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

-- local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- error_header = "  Error",
-- warn_header = "  Warn",
-- hint_header = "  Hint",
-- infor_header = "  Infor",
-- max_diag_msg_width = 50,
-- code_action_icon = ' ',
-- code_action_keys = { quit = 'q',exec = '<CR>' }
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border | 4: ascii border
-- border_style = 1
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

-- or --use default config
-- saga.init_lsp_saga {}

-- require'lsp_signature'.on_attach()

local rusttools_ok, rusttools = pcall(require, 'rust-tools')
if not rusttools_ok then
    return
end
rusttools.setup {
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set('n', 'K', rusttools.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set('n', '<Leader>la', rusttools.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Turn on lsp status information
require('fidget').setup()
