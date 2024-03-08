---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local noice_ok, noice = pcall(require, 'noice')
if not noice_ok then
    vim.notify 'noice plugin not loaded!'
    return
end

noice.setup {
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
        },
    },
    cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = '^:', icon = '', lang = 'vim' },
            search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
            search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
            filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
            lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
            help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
            input = {}, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
        },
    },
    messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = 'notify', -- default view for messages
        view_error = 'notify', -- view for errors
        view_warn = 'notify', -- view for warnings
        view_history = 'messages', -- view for :messages
        view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    routes = {
        -- no_autosave = {
        --     filter = {
        --         event = 'msg_show',
        --         kind = '',
        --         -- find = 'AutoSave: saved',
        --         find = 'written',
        --         -- view = 'popup',
        --     },
        --     opts = { skip = true },
        -- },
        default = {
            view = 'notify',
            filter = { event = 'msg_showmode' },
        },
    },
    views = {
        cmdline_popup = {
            position = {
                row = 5,
                col = '50%',
            },
            size = {
                width = 60,
                height = 'auto',
            },
        },
        popupmenu = {
            relative = 'editor',
            position = {
                row = 8,
                col = '50%',
            },
            size = {
                width = 60,
                height = 10,
            },
            border = {
                style = 'rounded',
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
            },
        },
    },
}
