-- luacheck: globals vim
---@diagnostic disable: undefined-global

-- TODO: move all dependent keymaps to its dependency
-- TODO: define a useful description for all maps
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- Convention:
--   g...git
--   f...find
--   l...LSP stuff
--   s...session
--   t...terminal

-- Shorten function name
local map = vim.keymap.set
-- Keymaps for better default experience See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map({ 'n', 'v' }, ',', '<Nop>', { silent = true })
-- General
map('i', 'jk', '<esc>', { noremap = true, silent = true })
map('t', 'jk', '<c-\\><c-n>', { noremap = true, silent = true })
map('n', 'n', 'nzzzv', { noremap = true, silent = true })
map('n', 'N', 'Nzzzv', { noremap = true, silent = true })
map('n', 'Q', '@@', { noremap = true, silent = true })
map('c', 'W!', 'w !doas tee %', { noremap = true, silent = true }) -- write as root
map('c', 'Q!', 'q!', { noremap = true, silent = true })
map('c', 'Qa!', 'qa!', { noremap = true, silent = true })
map('i', '<c-bs>', '<c-w>', { noremap = true, silent = true }) -- ctrl-backspace to delete previous word
map('i', '<c-h>', '<c-w>', { noremap = true, silent = true })  -- ctrl-backspace to delete previous word
-- Move visual block
map('v', 'J', ':m +1<CR>gv=gv', { noremap = true, silent = true })
map('v', 'K', ':m -2<CR>gv=gv', { noremap = true, silent = true })
-- jump between buffers in normal mode
map('n', '<c-h>', '<c-w>h', { noremap = true, silent = true })
map('n', '<c-j>', '<c-w>j', { noremap = true, silent = true })
map('n', '<c-k>', '<c-w>k', { noremap = true, silent = true })
map('n', '<c-l>', '<c-w>l', { noremap = true, silent = true })
-- jump between buffers in visual mode
map('x', '<c-h>', '<c-w>h', { noremap = true, silent = true })
map('x', '<c-j>', '<c-w>j', { noremap = true, silent = true })
map('x', '<c-k>', '<c-w>k', { noremap = true, silent = true })
map('x', '<c-l>', '<c-w>l', { noremap = true, silent = true })
-- Better terminal navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h', { silent = true })
map('t', '<C-j>', '<C-\\><C-N><C-w>j', { silent = true })
map('t', '<C-k>', '<C-\\><C-N><C-w>k', { silent = true })
map('t', '<C-l>', '<C-\\><C-N><C-w>l', { silent = true })
-- Resize with arrows
map('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
map('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
map('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
map('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })
-- remove ^M from dos files
-- map("n", "<leader>m", ":e ++ff=dos<cr>", { noremap = true, silent = true })
-- move vertically by visual line
-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- highlight last inserted text
map('n', 'gV', '`[v`]', { noremap = true, silent = true })
-- Buffer
-- map('n', '<Leader>h', ':<C-u>split<CR>', { noremap = true, silent = true })
-- map('n', '<Leader>v', ':<C-u>vsplit<CR>', { noremap = true, silent = true })
-- map("n", "<leader>z", ":bp<CR>", { noremap = true, silent = true })
-- map("n", "<leader>x", ":bn<CR>", { noremap = true, silent = true })
-- map("n", "<leader>c", ":bd<CR>", { noremap = true, silent = true })
map('n', '<S-l>', ':bnext<CR>', { noremap = true, silent = true })
map('n', '<S-h>', ':bprevious<CR>', { noremap = true, silent = true })
-- Yank Highlight
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
-- Session management
-- map('n', '<leader>so', ':OpenSession<Space>', { noremap = true, silent = true, desc = '[s]ession [o]pen' })
-- map('n', '<leader>ss', ':SaveSession<Space>', { noremap = true, silent = true, desc = '[s]ession [s]ave' })
-- map('n', '<leader>sc', ':CloseSession<CR>', { noremap = true, silent = true, desc = '[s]ession [c]reate' })
-- map('n', '<leader>sd', ':DeleteSession<CR>', { noremap = true, silent = true, desc = '[s]ession [d]elete' })
-- Tagbar
map('n', '<Leader>tb', ':SidebarNvimToggle<CR>', { noremap = true, silent = true, desc = '[t]ag[b]ar' })
-- LSP
map('n', '<leader>la', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = '[l]sp code [a]ction' })
map('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = '[K] ... hover' })
map('n', '<leader>lS', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = '[l]sp [S]ignature help' })
map('n', '<leader>lR', vim.lsp.buf.rename, { noremap = true, silent = true, desc = '[l]sp [R]ename' })
map('n', '<leader>le', vim.lsp.diagnostic.get_line_diagnostics, {
    noremap = true,
    silent = true,
    desc = '[l]sp [e]rror diagnostic',
})
map('n', '[e', vim.diagnostic.goto_prev, { noremap = true, silent = true })
map('n', ']e', vim.diagnostic.goto_next, { noremap = true, silent = true })
map('n', '<leader>lr', vim.lsp.buf.references, { noremap = true, silent = true, desc = '[l]sp [r]eferences' })
map('n', '<leader>ld', vim.lsp.buf.definition, { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
map('n', '<leader>lD', vim.lsp.buf.declaration, { noremap = true, silent = true, desc = '[l]sp [D]eclaration' })
map('n', '<leader>li', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = '[l]sp [i]implementation' })
map('n', '<leader>lI', vim.lsp.buf.incoming_calls, { noremap = true, silent = true, desc = '[l]sp [I]ncoming calls' })
map('n', '<leader>lO', vim.lsp.buf.outgoing_calls, { noremap = true, silent = true, desc = '[l]sp [O]outgoing calls' })
map('n', '<leader>lt', vim.lsp.buf.type_definition, { noremap = true, silent = true, desc = '[l]sp [t]ype definition' })
map('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, {
    noremap = true,
    silent = true,
    desc = '[l]sp [w]orkspace [a]dd',
})
map('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, {
    noremap = true,
    silent = true,
    desc = '[l]sp [w]orkspace [r]emove',
})
map('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { noremap = true, silent = true, desc = '[l]sp [w]orkspace folder [l]ist' })
-- TODO: move LSP keymaps to lsp_config.lua and only load if LSP is loaded
map('n', '<c-]>', vim.lsp.buf.definition, { noremap = true, silent = true, desc = '[c-]] ... tags basd on lsp' })
-- Open applications
map('n', '<c-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = '[c-n]vim tree toggle' })
map('n', '<Leader>gd', ':Gvdiff<CR>', { noremap = true, silent = true, desc = '[g]it [d]iff' })

map('n', '<leader>gm', '<cmd>Gitsign blame_line<cr>', {
    noremap = true,
    silent = true,
    desc = '[g]it [m]essage from git blame',
})
map('n', '[g', '<cmd>Gitsign prev_hunk<cr>', { noremap = true, silent = true, desc = '[[g]it - previous hunk' })
map('n', ']g', '<cmd>Gitsign next_hunk<cr>', { noremap = true, silent = true, desc = '[]g]it - next hunk' })

-- Trouble
map('n', '<leader>xx', '<cmd>Trouble<cr>', { silent = true, noremap = true })
map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', { silent = true, noremap = true })
map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', { silent = true, noremap = true })
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { silent = true, noremap = true })
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true })
map('n', 'gR', '<cmd>Trouble lsp_references<cr>', { silent = true, noremap = true })

-- GUI mode - zooms
map('n', '<C-ScrollWheelUp>', '<cmd>AdjustFontSize(1)<CR>', { silent = true, noremap = true })
map('n', '<C-ScrollWheelDown>', '<cmd>AdjustFontSize(-1)<CR>', { silent = true, noremap = true })
map('i', '<C-ScrollWheelUp>', '<Esc><cmd>AdjustFontSize(1)<CR>a', { silent = true, noremap = true })
map('i', '<C-ScrollWheelDown>', '<Esc><cmd>AdjustFontSize(-1)<CR>a', { silent = true, noremap = true })

-- Debugging
map('n', '<leader>db', '<cmd>DapToggleBreakpoint<cr>', { noremap = true, silent = true })
map('n', '<leader>dc', '<cmd>DapContinue<cr>', { noremap = true, silent = true })
map('n', '<leader>di', '<cmd>DapStepInto<cr>', { noremap = true, silent = true })
map('n', '<leader>do', '<cmd>DapStepOver<cr>', { noremap = true, silent = true })
map('n', '<leader>du', '<cmd>DapStepOut<cr>', { noremap = true, silent = true })
map('n', '<leader>dr', '<cmd>DapToggleRepl<cr>', { noremap = true, silent = true })
map('n', '<leader>dl', '<cmd>DapShowLog<cr>', { noremap = true, silent = true })
map('n', '<leader>dt', '<cmd>DapTerminate<cr>', { noremap = true, silent = true })
map('n', '<leader>dB', '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>', {
    noremap = true,
    silent = true,
})
map('n', '<leader>dm', '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>', {
    noremap = true,
    silent = true,
})
map('n', '<leader>dR', 'run_last()<cr>', { noremap = true, silent = true })
map('n', '<leader>dC', '<cmd>Telescope dap commands<cr>', { noremap = true, silent = true })
map('n', '<leader>dF', '<cmd>Telescope dap configurations<cr>', { noremap = true, silent = true })
map('n', '<leader>dL', '<cmd>Telescope dap list_breakpoints<cr>', { noremap = true, silent = true })
map('n', '<leader>dV', '<cmd>Telescope dap variables<cr>', { noremap = true, silent = true })

-- Tree SJ
map('n', '<leader>J', function()
    require('treesj').toggle { split = { recursive = true } }
end, { noremap = true, silent = true, desc = '[J]oin line toggle - syntax aware' })

-- TODO: check neotest and use leader-t etc
