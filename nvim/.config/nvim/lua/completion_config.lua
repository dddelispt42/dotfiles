-- luacheck: globals vim
---@diagnostic disable: undefined-global

local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
    vim.notify 'cmp plugin not loaded!'
    return
end
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
    vim.notify 'luasnip plugin not loaded!'
    return
end

-- Global setup.
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'treesitter' },
        { name = 'buffer' },
        -- { name = "neorg" },
        { name = 'orgmode' },
        { name = 'path' },
        { name = 'crates' },
        { name = 'dap' },
        { name = 'emoji' },
        { name = 'nvim_lua' },
        { name = 'spell' },
    },
    -- nvim-cmp by defaults disables autocomplete for prompt buffers
    enabled = function()
        return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
    end,
}
-- `/` cmdline setup.
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    },
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').lazy_load()
-- TODO: add own snippets

local cmplsp_ok, cmplsp = pcall(require, 'cmp_nvim_lsp')
if not cmplsp_ok then
    vim.notify 'cmp_nvim_lsp plugin not loaded!'
    return
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
cmplsp.default_capabilities(capabilities)
