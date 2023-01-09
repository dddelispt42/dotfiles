-- luacheck: globals vim
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
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
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    -- { name = "treesitter" },
    -- { name = "buffer" },
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
