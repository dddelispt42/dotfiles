---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local none_ls_status_ok, none_ls = pcall(require, 'null-ls')
if not none_ls_status_ok then
    vim.notify 'none-ls plugin not loaded!'
    return
end
local mason_null_ls_status_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not mason_null_ls_status_ok then
    vim.notify 'mason-null-ls plugin not loaded!'
    return
end

mason_null_ls.setup {
    -- A list of sources to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {
        'alejandra',
        'ansiblelint',
        'asmfmt',
        'bibclean',
        'nginx_beautifier',
        'nixfmt',
        'nixpkg_fmt',
        'biome',
        'buf',
        'cbfmt',
        'commitlint',
        'cppcheck',
        'deadnix',
        'dotenv_linter',
        'editorconfig-checker',
        'format_r',
        'gitlint',
        'gitrebase',
        'gitsigns',  -- TODO: check
        'gofmt',
        'hadolint',
        'jq',
        'just',
        -- 'leptosfmt',
        'markdownlint',
        'proselint',
        'protolint',
        'refactoring',
        'selene',
        'shfmt',
        'sqlfmt',
        'statix',
        'stylua',
        'tflint',
        'vacuum',
        'vint',
        'yamllint',
    },
    -- Run `require("null-ls").setup`.
    -- Will automatically install masons tools based on selected sources in `null-ls`.
    -- Can also be an exclusion list.
    -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraih" } }`
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
none_ls.setup {
    debug = false,
    -- debounce = 500,
    sources = {
        none_ls.builtins.code_actions.gitrebase,
        none_ls.builtins.code_actions.gitsigns,
        none_ls.builtins.code_actions.impl,
        none_ls.builtins.code_actions.proselint,
        none_ls.builtins.code_actions.refactoring,
        none_ls.builtins.code_actions.statix,
        none_ls.builtins.completion.luasnip,
        none_ls.builtins.completion.spell,
        none_ls.builtins.diagnostics.ansiblelint,
        none_ls.builtins.diagnostics.buf,
        none_ls.builtins.diagnostics.commitlint,
        none_ls.builtins.diagnostics.cppcheck,
        none_ls.builtins.diagnostics.deadnix,
        none_ls.builtins.diagnostics.dotenv_linter,
        none_ls.builtins.diagnostics.gitlint,
        none_ls.builtins.diagnostics.hadolint,
        none_ls.builtins.diagnostics.markdownlint,
        none_ls.builtins.diagnostics.mlint,
        none_ls.builtins.diagnostics.npm_groovy_lint,
        none_ls.builtins.diagnostics.pmd,
        none_ls.builtins.diagnostics.rpmspec,
        none_ls.builtins.diagnostics.rstcheck,
        none_ls.builtins.diagnostics.selene,
        none_ls.builtins.diagnostics.sqlfluff,
        none_ls.builtins.diagnostics.statix,
        none_ls.builtins.diagnostics.todo_comments,
        none_ls.builtins.diagnostics.trail_space,
        none_ls.builtins.diagnostics.trivy,
        none_ls.builtins.diagnostics.vacuum,
        none_ls.builtins.diagnostics.vint,
        none_ls.builtins.diagnostics.yamllint,
        none_ls.builtins.diagnostics.zsh,
        none_ls.builtins.formatting.alejandra,
        none_ls.builtins.formatting.asmfmt,
        none_ls.builtins.formatting.bibclean,
        none_ls.builtins.formatting.buf,
        none_ls.builtins.formatting.cbfmt,
        none_ls.builtins.formatting.clang_format,
        none_ls.builtins.formatting.format_r,
        none_ls.builtins.formatting.gofmt,
        none_ls.builtins.formatting.goimports,
        none_ls.builtins.formatting.just,
        -- none_ls.builtins.formatting.leptosfmt,
        none_ls.builtins.formatting.nginx_beautifier,
        none_ls.builtins.formatting.nixfmt,
        none_ls.builtins.formatting.nixpkgs_fmt,
        none_ls.builtins.formatting.npm_groovy_lint,
        none_ls.builtins.formatting.protolint,
        none_ls.builtins.formatting.rustywind,
        none_ls.builtins.formatting.shfmt,
        none_ls.builtins.formatting.sqlformat,
        none_ls.builtins.formatting.stylua,
        none_ls.builtins.hover.dictionary,
        none_ls.builtins.hover.printenv,
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
                    -- vim.lsp.buf.format { bufnr = bufnr }
                    -- lsp_formatting(bufnr)
                end,
            })
        end
    end,
}
-- If `automatic_setup` is true.
-- mason_null_ls.setup_handlers()
