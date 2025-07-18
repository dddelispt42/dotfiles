---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
    vim.notify 'mason plugin not loaded!'
    return
end

local my_lsps = {
    'angularls',
    'ansiblels',
    'arduino_language_server',
    'asm_lsp',
    -- 'ast_grep',
    'autotools_ls',
    'bashls',
    'biome',
    'buf_ls',
    'clangd',
    'clojure_lsp',
    'cmake',
    'cssls',
    'cssmodules_ls',
    'docker_compose_language_service',
    'dockerls',
    'dotls',
    'emmet_ls',
    'golangci_lint_ls',
    'gopls',
    'gradle_ls',
    'helm_ls',
    'html',
    'htmx',
    'jdtls',
    'jsonls',
    'julials',
    'lemminx',
    'lua_ls',
    'marksman',
    'mutt_ls',
    'nginx_language_server',
    'ols',
    'opencl_ls',
    'openscad_lsp',
    'prosemd_lsp',
    -- 'pylyzer',
    -- 'pyre',
    'pyright',
    'quick_lint_js',
    'reason_ls',
    'remark_ls',
    'rescriptls',
    'rnix',
    'ruff',
    'rust_analyzer',
    'slint_lsp',
    'smithy_ls',
    'spectral',
    'stimulus_ls',
    'stylelint_lsp',
    'tailwindcss',
    'taplo',
    'terraformls',
    'texlab',
    'tflint',
    'thriftls',
    'ts_ls',
    'typos_lsp',
    'unocss',
    'veryl_ls',
    'vimls',
    'visualforce_ls',
    'vtsls',
    'yamlls',
    'zls',
}

if vim.loop.os_uname().sysname == 'Windows_NT' then
    my_lsps = {
        'docker_compose_language_service',
        'dockerls',
        'dotls',
        'emmet_ls',
        'html',
        'jdtls',
        'jsonls',
        'lemminx',
        'ruff',
        'taplo',
        'typos_lsp',
        'yamlls',
    }
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
require('mason-lspconfig').setup {
    ensure_installed = my_lsps,
    automatic_installation = true,
}

local nvim_lsp = require 'lspconfig'

if vim.loop.os_uname().sysname == 'Linux' then
    -- nvim_lsp.yang_lsp.setup {}
    nvim_lsp.angularls.setup {}
    nvim_lsp.ansiblels.setup {}
    nvim_lsp.arduino_language_server.setup {}
    nvim_lsp.asm_lsp.setup {}
    nvim_lsp.autotools_ls.setup {}
    nvim_lsp.bashls.setup {}
    nvim_lsp.biome.setup {}
    -- nvim_lsp.bufls.setup {}
    -- nvim_lsp.ccls.setup {}
    nvim_lsp.clangd.setup {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        cmd = {
            'clangd',
            '--offset-encoding=utf-16',
        },
    }
    nvim_lsp.cmake.setup {}
    nvim_lsp.cssls.setup {}
    nvim_lsp.cssmodules_ls.setup {}
    nvim_lsp.golangci_lint_ls.setup {}
    nvim_lsp.gopls.setup {}
    nvim_lsp.gradle_ls.setup {}
    nvim_lsp.helm_ls.setup {}
    nvim_lsp.htmx.setup {}
    nvim_lsp.julials.setup {}
    nvim_lsp.lua_ls.setup {}
    nvim_lsp.marksman.setup {}
    nvim_lsp.mutt_ls.setup {}
    -- TODO(heiko): does not work with newest python version
    -- nvim_lsp.nginx_language_server.setup {}
    nvim_lsp.openscad_lsp.setup {}
    nvim_lsp.pyright.setup {}
    -- TODO(heiko): retest - did not find modules (bug)
    -- nvim_lsp.pylyzer.setup {}
    nvim_lsp.rnix.setup {}
    -- nvim_lsp.rust_analyzer.setup {}
    -- nvim_lsp.sonarlint.setup {}
    nvim_lsp.spectral.setup {}
    nvim_lsp.stylelint_lsp.setup {}
    nvim_lsp.tailwindcss.setup {}
    nvim_lsp.texlab.setup {}
    nvim_lsp.tflint.setup {}
    nvim_lsp.ts_ls.setup {}
    nvim_lsp.vimls.setup {}
    nvim_lsp.zls.setup {}
end

nvim_lsp.docker_compose_language_service.setup {}
nvim_lsp.dockerls.setup {}
nvim_lsp.dotls.setup {}
nvim_lsp.emmet_ls.setup {}
nvim_lsp.html.setup {}
nvim_lsp.jdtls.setup {}
nvim_lsp.lemminx.setup {}
nvim_lsp.ruff.setup {}
nvim_lsp.taplo.setup {}
nvim_lsp.typos_lsp.setup {
    init_options = {
        -- Custom config. Used together with any workspace config files, taking precedence for
        -- settings declared in both. Equivalent to the typos `--config` cli argument.
        config = '~/.config/typos.toml',
        -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
        -- Defaults to error.
        diagnosticSeverity = 'information',
    },
}

nvim_lsp.jsonls.setup {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas {
                -- select = {
                --     '.eslintrc',
                --     'package.json',
                -- },
                -- ignore = {},
            },
            validate = { enable = true },
            format = { enable = true },
            colorDecorators = { enable = true },
        },
    },
}
nvim_lsp.yamlls.setup {
    settings = {
        yaml = {
            completion = true,
            validate = true,
            format = { enable = true },
            hover = true,
            printWidth = 120,
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = true,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            schemas = require('schemastore').yaml.schemas {
                -- ignore = {
                --     '.eslintrc',
                -- },
            },
            -- TODO: add schema for mappings
            -- extra = {
            --     {
            --         description = 'My custom JSON schema',
            --         fileMatch = 'foo.json',
            --         name = 'foo.json',
            --         url = 'https://example.com/schema/foo.json',
            --     },
            --     {
            --         description = 'My other custom JSON schema',
            --         fileMatch = { 'bar.json', '.baar.json' },
            --         name = 'bar.json',
            --         url = 'https://example.com/schema/bar.json',
            --     },
            -- },
        },
    },
}

-- Enable diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

-- local rusttools_ok, rusttools = pcall(require, 'rust-tools')
-- if not rusttools_ok then
--     vim.notify 'rust-tools plugin not loaded!'
--     return
-- end
-- rusttools.setup {
--     server = {
--         on_attach = function(_, bufnr)
--             -- Hover actions
--             vim.keymap.set('n', 'K', rusttools.hover_actions.hover_actions, { buffer = bufnr })
--             -- Code action groups
--             vim.keymap.set('n', '<Leader>la', rusttools.code_action_group.code_action_group, { buffer = bufnr })
--         end,
--     },
-- }
-- local rusttools_ok, rusttools = pcall(require, 'rust-tools')

local rustaceanvim_ok, rustaceanvim = pcall(require, 'rustaceanvim')
if not rustaceanvim_ok then
    vim.notify 'rustaceanvim plugin not loaded!'
    return
end

vim.g.rustaceanvim = function()
  -- Update this path
  local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb'
  local this_os = vim.uv.os_uname().sysname;

  -- The path is different on Windows
  if this_os:find "Windows" then
    codelldb_path = extension_path .. "adapter\\codelldb.exe"
    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
  else
    -- The liblldb extension is .so for Linux and .dylib for MacOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
  end

  local cfg = require('rustaceanvim.config')
  return {
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end
--
-- Setup neovim lua configuration
require('neodev').setup()

-- Turn on lsp status information
require('fidget').setup {
    progress = {
        poll_rate = 1, -- How and when to poll for progress messages
        suppress_on_insert = true, -- Suppress new messages while in insert mode
        ignore_done_already = true, -- Ignore new tasks that are already complete
        ignore_empty_message = true, -- Ignore new tasks that don't contain a message

        display = {
            render_limit = 3,
        },
        lsp = {
            progress_ringbuf_size = 3,
        },
    },
    notification = {
        poll_rate = 10, -- How frequently to update and render notifications
        filter = vim.log.levels.INFO, -- Minimum notifications level
    },
}

require('mason-tool-installer').setup {

    -- a list of all tools you want to ensure are installed upon
    -- start
    ensure_installed = my_lsps,

    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    -- Default: false
    auto_update = true,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = true,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay

    -- Only attempt to install if 'debounce_hours' number of hours has
    -- elapsed since the last time Neovim was started. This stores a
    -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
    -- This is only relevant when you are using 'run_on_start'. It has no
    -- effect when running manually via ':MasonToolsInstall' etc....
    -- Default: nil
    debounce_hours = 50, -- at least 5 hours between attempts to install/update
}
