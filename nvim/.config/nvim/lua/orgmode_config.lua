-- luacheck: globals vim
local orgmode_ok, orgmode = pcall(require, "neorg")
if not orgmode_ok then
    return
end


orgmode.setup {
    load = {
        ["core.defaults"] = {},
        ["core.highlights"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
            }
        },
        ["core.norg.journal"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.qol.toc"] = {},
        ["core.norg.qol.todo_items"] = {
            config = { task_cycle = '<S-Space>' }
        },
        ["core.syntax"] = {},
        ["core.tangle"] = {},
        ['core.norg.completion'] = {
            config = { engine = 'nvim-cmp' }
        },
        ['core.export'] = {},
        ['core.export.markdown'] = {},
        ['core.presenter'] = {
            config = { zen_mode = 'zen-mode' }
        },
        ['core.integrations.treesitter'] = {},
        ['core.norg.esupports.metagen'] = {},
    }
}

vim.api.nvim_set_keymap("n", "<leader>oc", "<cmd>Neorg gtd capture<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>oi", "<cmd>Neorg workspace home<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>oe", "<cmd>Neorg gtd edit<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>ov", "<cmd>Neorg gtd views<CR>", {
  noremap = true,
  silent = true,
})
