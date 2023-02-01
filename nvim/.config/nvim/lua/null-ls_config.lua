-- luacheck: globals vim
local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end
local mason_null_ls_status_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not mason_null_ls_status_ok then
    return
end
-- local null_ls = require("null-ls")
mason_null_ls.setup {
    -- A list of sources to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {
        -- 'ansiblelint',
        -- 'fixjson',
        'gitrebase',
        'gitsign',
        'gofmt',
        -- 'goimports',
        'jq',
        -- "luacheck",
        -- 'markdownlint',
        -- 'prettier',
        'protolint',
        'refactoring',
        'shellcheck',
        'ruff',
        'clang_format',
        'shfmt',
        'sqlformat',
        'stylelint',
        'stylua',
        'vint',
        'yamllint',
    },
    -- Run `require("null-ls").setup`.
    -- Will automatically install masons tools based on selected sources in `null-ls`.
    -- Can also be an exclusion list.
    -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
    automatic_installation = true,
    -- Whether sources that are installed in mason should be automatically set up in null-ls.
    -- Removes the need to set up null-ls manually.
    -- Can either be:
    -- 	- false: Null-ls is not automatically registered.
    -- 	- true: Null-ls is automatically registered.
    -- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
    -- 	Ex: { types = { eslint_d = {'formatting'} } }
    automatic_setup = false,
}

-- If `automatic_setup` is false.
null_ls.setup {
    debug = false,
    sources = {
        -- null_ls.builtins.formatting.prettier.with {
        --   extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
        -- },
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.sqlformat,
        null_ls.builtins.formatting.stylelint,
        null_ls.builtins.formatting.trim_whitespace,
        null_ls.builtins.formatting.xmllint,
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.ruff,
        -- null_ls.builtins.diagnostics.ansiblelint,
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.diagnostics.gitlint,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.vint,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.gitrebase,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.hover.dictionary,
        require('null-ls-embedded').nls_source,
    },
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- vim.lsp.buf.formatting_sync()
                    vim.lsp.buf.format { bufnr = bufnr }
                    -- lsp_formatting(bufnr)
                end,
            })
        end
    end,
}
-- If `automatic_setup` is true.
-- mason_null_ls.setup_handlers()
