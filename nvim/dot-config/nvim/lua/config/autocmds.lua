-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespace",
  pattern = { "*" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    -- Only trim lines that are not in markdown code blocks (leave trailing two spaces for hard break)
    if vim.bo.filetype ~= "markdown" then
      vim.cmd([[%s/\s\+$//e]])
    end
    vim.fn.setpos(".", save_cursor)
  end,
})
