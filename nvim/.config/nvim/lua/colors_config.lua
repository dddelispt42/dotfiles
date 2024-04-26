---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

local catppuccin_ok, catppuccin = pcall(require, 'catppuccin')
if not catppuccin_ok then
    vim.notify 'catppuccin plugin not loaded!'
    return
end

catppuccin.setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        neotree = true,
        noice = true,
        neotest = true,
        treesitter = true,
        notify = false,
        flash = true,
        aerial = true,
        harpoon = true,
        mason = true,
        -- lsp_saga = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

vim.opt.termguicolors = true -- enable true-color support
vim.o.background = 'dark'    -- or "light" for light mode

local colorscheme = 'catppuccin'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

local colorizer_ok, colorizer = pcall(require, 'colorizer')
if not colorizer_ok then
    vim.notify 'colorizer plugin not loaded!'
    return
end
colorizer.setup()
