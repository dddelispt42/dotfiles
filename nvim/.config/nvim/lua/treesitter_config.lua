-- luacheck: globals vim
---@diagnostic disable: undefined-global

local ts_ok, ts = pcall(require, 'nvim-treesitter.configs')
if not ts_ok then
    return
end

vim.api.nvim_exec(
    [[    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    ]],
    false
)

ts.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        'arduino',
        'awk',
        'bash',
        'bibtex',
        'c',
        -- 'c_sharp',
        'clojure',
        'cmake',
        'comment',
        'commonlisp',
        'cpon',
        'cpp',
        -- 'd',
        -- 'dart',
        'devicetree',
        'diff',
        'dockerfile',
        'dot',
        'elixir',
        -- 'elm',
        -- 'erlang',
        -- 'fish',
        -- 'fortran',
        'fsh',
        'func',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gowork',
        -- 'graphql',
        -- 'hack',
        -- 'haskell',
        'hjson',
        'html',
        -- 'htmldjango',
        'http',
        'ini',
        'java',
        'javascript',
        'jq',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'julia',
        'latex',
        'llvm',
        'lua',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        -- 'matlab',
        'mermaid',
        'nix',
        'norg',
        'ocaml',
        'org',
        'passwd',
        'perl',
        -- 'php',
        'proto',
        'python',
        'r',
        'rasi',
        'regex',
        'ruby',
        'rust',
        -- 'scala',
        'scheme',
        'sql',
        -- 'svelte',
        -- 'swift',
        -- 'teal',
        'terraform',
        'todotxt',
        'toml',
        'typescript',
        'v',
        'vim',
        'vimdoc',
        -- 'vue',
        'yaml',
        'yang',
        'zig',
    },
    -- ensure_installed = 'all',

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    highlight = {
        enable = true,
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 1024 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'gnn',
            scope_incremental = 'gnc',
            -- node_decremental = 'gnd',
            node_decremental = '<bs>',
        },
    },
    indent = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of parameter' },
                ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of parameter' },
                ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of conditional' },
                ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of conditional' },
                ['al'] = { query = '@loop.outer', desc = 'Select outer part of loop' },
                ['il'] = { query = '@loop.inner', desc = 'Select inner part of loop' },
                ['ac'] = { query = '@call.outer', desc = 'Select outer part of call' },
                ['ic'] = { query = '@call.inner', desc = 'Select inner part of call' },
                ['af'] = { query = '@function.outer', desc = 'Select outer part of function' },
                ['if'] = { query = '@function.inner', desc = 'Select inner part of function' },
                ['aC'] = { query = '@class.outer', desc = 'Select outer part of class' },
                ['iC'] = { query = '@class.inner', desc = 'Select inner part of class' },
                ['ak'] = { query = '@comment.outer', desc = 'Select outer part of comment' },
                ['ik'] = { query = '@comment.inner', desc = 'Select inner part of comment' },
                ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
                ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
                ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
                ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
                ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = { query = '@function.outer', desc = 'Goto next function' },
                [']]'] = { query = '@class.outer', desc = 'Goto next class' },
                [']o'] = '@loop.*',
                [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
                [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
            },
            goto_next_end = {
                [']M'] = { query = '@function.outer', desc = 'Goto end of next function' },
                [']['] = { query = '@class.outer', desc = 'Goto end of next class' },
                [']O'] = '@loop.*',
                [']S'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
                [']Z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
            },
            goto_previous_start = {
                ['[m'] = { query = '@function.outer', desc = 'Goto of previous function' },
                ['[['] = { query = '@class.outer', desc = 'Goto of previous class' },
                ['[o'] = '@loop.*',
                ['[s'] = { query = '@scope', query_group = 'locals', desc = 'Previous scope' },
                ['[z'] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
            },
            goto_previous_end = {
                ['[M'] = { query = '@function.outer', desc = 'Goto end of previous function' },
                ['[]'] = { query = '@class.outer', desc = 'Goto end of previous class' },
                ['[='] = '@loop.*',
                ['[S'] = { query = '@scope', query_group = 'locals', desc = 'Previous scope' },
                ['[Z'] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>sa'] = { query = '@parameter.inner', desc = 'Swap arg with next' },
                ['<leader>sf'] = { query = '@funtion.outer', desc = 'Swap function with next' },
            },
            swap_previous = {
                ['<leader>sA'] = { query = '@parameter.inner', desc = ' arg with previous' },
                ['<leader>sF'] = { query = '@funtion.outer', desc = 'Swap function with next' },
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
                ['<leader>df'] = { query = '@function.outer', desc = '' },
                ['<leader>dF'] = { query = '@class.outer', desc = '' },
            },
        },
    },
}
