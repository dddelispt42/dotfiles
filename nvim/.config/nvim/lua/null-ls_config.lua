-- luacheck: globals vim

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end
-- local null_ls = require("null-ls")

-- code action sources
local code_actions = null_ls.builtins.code_actions
-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics
-- formatting sources
local formatting = null_ls.builtins.formatting
-- hover sources
local hover = null_ls.builtins.hover
-- completion sources
local completions = null_ls.builtins.completion

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

if os.getenv("OS") ~= "Windows_NT" then
	-- null_ls.setup({
	null_ls.setup({
		debug = false,
		sources = {
			formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
			formatting.black.with({ extra_args = { "--fast" } }),
			-- formatting.black,
			-- formatting.asmfmt,
			-- formatting.autopep8,
			-- formatting.brittany,
			formatting.clang_format,
			-- formatting.cljstyle,
			-- formatting.cmake_format,
			-- formatting.dart_format,
			-- formatting.deno_fmt,
			-- formatting.fixjson,
			-- formatting.format_r,
			formatting.gofmt,
			-- formatting.goimports,
			formatting.isort,
			-- formatting.lua_format,
			-- formatting.latexindent,
			-- formatting.nginx_beautifier,
			-- formatting.nixfmt,
			-- formatting.pg_format,
			-- formatting.phpcbf,
			-- formatting.protolint,
			-- using rust-analyzer already
			-- formatting.rustfmt,
			formatting.shfmt,
			-- INFO: this is too aggressive and often breaks scripts
			-- formatting.shellharden,
			formatting.sqlformat,
			formatting.stylelint,
			formatting.trim_whitespace,
			formatting.xmllint,
			-- formatting.zigfmt,
			-- formatting.nimpretty,
			formatting.stylua,
			diagnostics.flake8,
			-- diagnostics.mypy,
			-- diagnostics.php,
			diagnostics.ansiblelint,
			-- diagnostics.checkmake,
			-- diagnostics.codespell,
			diagnostics.cppcheck,
			diagnostics.gitlint,
			-- diagnostics.pylama,
			-- diagnostics.hadolint,
			-- diagnostics.jsonlint,
			diagnostics.luacheck,
			-- diagnostics.markdownlint,
			-- diagnostics.mdl,
			-- diagnostics.protolint,
			diagnostics.pydocstyle,
			-- diagnostics.pylint,
			-- diagnostics.selene,
			diagnostics.shellcheck,
			diagnostics.vint,
			-- diagnostics.vulture,
			-- diagnostics.xo,
			diagnostics.yamllint,
			code_actions.gitsigns,
			code_actions.refactoring,
			code_actions.gitrebase,
			code_actions.shellcheck,
			-- code_actions.xo,
			hover.dictionary,
			-- completions.spell,
			-- completions.tags,
		},
		on_attach = function(client)
			if client.server_capabilities.document_formatting then
				vim.cmd([[
                augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                augroup END
                ]])
			end
		end,
	})
end
