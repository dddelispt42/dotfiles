-- luacheck: globals vim
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
        'c_sharp',
        'clojure',
        'cmake',
        'comment',
        'commonlisp',
        'cpon',
        'cpp',
        'd',
        'dart',
        'devicetree',
        'diff',
        'dockerfile',
        'dot',
        'elixir',
        'elm',
        'erlang',
        'fish',
        'fortran',
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
        'graphql',
        'hack',
        'haskell',
        'hjson',
        'html',
        'htmldjango',
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
        'matlab',
        'mermaid',
        'nix',
        'norg',
        'norg',
        'ocaml',
        'org',
        'passwd',
        'perl',
        'php',
        'proto',
        'python',
        'r',
        'rasi',
        'regex',
        'ruby',
        'rust',
        'rust',
        'scala',
        'scheme',
        'sql',
        'svelte',
        'swift',
        'teal',
        'terraform',
        'todotxt',
        'toml',
        'typescript',
        'v',
        'vim',
        'vimdoc',
        'vue',
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
            node_decremental = 'gnd',
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
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>sa'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>sA'] = '@parameter.inner',
            },
        },
    },
}
