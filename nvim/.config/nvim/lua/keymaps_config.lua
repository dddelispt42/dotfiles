-- luacheck: globals vim
-- TODO: move all dependent keymaps to its dependency
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

-- Define leader key
vim.g.mapleader = ',' -- 'vim.g' sets global variables
vim.g.maplocalleader = ','
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
map('v', '<leader>la', vim.lsp.buf.range_code_action, { noremap = true, silent = true, desc = '[l]sp code [a]ction' })
map('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = '[K] ... hover' })
map('n', '<leader>lS', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = '[l]sp [S]ignature help' })
map('n', '<leader>lR', vim.lsp.buf.rename, { noremap = true, silent = true, desc = '[l]sp [R]ename' })
map('n', '<leader>le', vim.lsp.diagnostic.get_line_diagnostics, {
    noremap = true,
    silent = true,
    desc = '[l]sp [e]rror diagnostic',
})
map('n', 'e[', vim.diagnostic.goto_prev, { noremap = true, silent = true })
map('n', 'e]', vim.diagnostic.goto_next, { noremap = true, silent = true })
map('n', '<leader>lr', vim.lsp.buf.references, { noremap = true, silent = true, desc = '[l]sp [r]eferences' })
map('n', '<leader>ld', vim.lsp.buf.definition, { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
map('n', '<leader>lD', vim.lsp.buf.declaration, { noremap = true, silent = true, desc = '[l]sp [D]eclaration' })
map('n', '<leader>li', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = '[l]sp [i]implementation' })
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

-- Telescope - new native lua style
map('n', '<leader>fA', '<cmd>Telescope autocommands<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [A]utocommand',
})
map('n', '<leader>b', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true, desc = 'find [b]uffer' })
map('n', '<leader>?', '<cmd>Telescope builtin<cr>', {
    noremap = true,
    silent = true,
    desc = '[?] find telescope buildins',
})
map('n', '<leader>C', '<cmd>Telescope colorscheme<cr>', {
    noremap = true,
    silent = true,
    desc = 'find [C]olorscheme',
})
map('n', '<leader>f:', '<cmd>Telescope command_history<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [:] commands',
})
map('n', '<leader>:', '<cmd>Telescope commands<cr>', {
    noremap = true,
    silent = true,
    desc = 'find [:] neovim commands',
})
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })
map('n', '<leader>f-', '<cmd>Telescope filetypes<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [-] file types',
})
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[f]ind [f]iles' })
-- map('n', '<leader>f.', '<cmd>Telescope find_files cwd="/home/heiko/.config"<cr>', { noremap = true, silent = true })
map('n', '<leader>gB', '<cmd>Telescope git_bcommits<cr>', { noremap = true, silent = true, desc = '[f]ind [B]commits' })
map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { noremap = true, silent = true, desc = '[f]ind [b]ranches' })
map('n', '<leader>gC', '<cmd>Telescope git_commits<cr>', { noremap = true, silent = true, desc = '[f]ind [C]ommits' })
map('n', '<leader>gf', '<cmd>Telescope git_files<cr>', { noremap = true, silent = true, desc = '[g]it [f]ile finder' })
map('n', '<leader>gS', '<cmd>Telescope git_status<cr>', { noremap = true, silent = true, desc = '[g]it [S]tatus' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[f]ind current [w]ord' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[f]ind [h]elp' })
map('n', '<leader>fH', '<cmd>Telescope highlights<cr>', { noremap = true, silent = true, desc = '[f]ind [H]ighlights' })
map('n', '<leader>fK', '<cmd>Telescope keymaps<cr>', { noremap = true, silent = true, desc = '[f]ind [K]eymaps' })
map('n', '<leader>fj', '<cmd>Telescope jumplist<cr>', { noremap = true, silent = true, desc = '[f]ind [j]umplist' })
vim.keymap.set('n', '<leader>a', require('telescope.builtin').live_grep, { desc = 'Find by live grep [a]' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[f]ind [d]iagnostics' })
map('n', '<leader>fll', '<cmd>Telescope loclist<cr>', { noremap = true, silent = true, desc = '[f]ind [l]oclist' })
map('n', '<leader>fla', '<cmd>Telescope lsp_code_actions<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp code [a]ction',
})
map('n', '<leader>fls', '<cmd>Telescope lsp_document_symbols<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp document [s]ymbols',
})
map('n', '<leader>flS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp workspace [s]ymbols',
})
map('v', '<leader>fla', '<cmd>Telescope lsp_range_code_actions<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp code [a]ctions',
})
map('n', '<leader>flr', '<cmd>Telescope lsp_references<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp [r]eferences',
})
map('n', '<leader>flw', '<cmd>Telescope lsp_workspace_symbols<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [l]sp [w]orkspace symbols',
})
map('n', '<leader>fm', '<cmd>Telescope man_pages<cr>', { noremap = true, silent = true, desc = '[f]ind [m]an pages' })
map('n', "<leader>f'", '<cmd>Telescope marks<cr>', { noremap = true, silent = true, desc = "[f]ind ['] marks" })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[f]ind recently [o]pened files' })
-- map('n', '<leader>fp', '<cmd>Telescope planets<cr>', { noremap = true, silent = true, desc = '[f]ind [p]lanets' })
map('n', '<leader>fq', '<cmd>Telescope quickfix<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [q]uickfix list',
})
map('n', '<leader>fr', '<cmd>Telescope registers<cr>', { noremap = true, silent = true, desc = '[f]ind [r]egisters' })
-- map('n', '<leader>fR', '<cmd>Telescope reloader<cr>', { noremap = true, silent = true, desc = '[f]ind [R]eloader' })
map('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>', { noremap = true, silent = true, desc = '[f]ind [s]pell' })
map('n', '<leader>fk', '<cmd>Telescope symbols<cr>', { noremap = true, silent = true, desc = '[f]ind [k] symbols' })
map('n', '<leader>fT', '<cmd>Telescope current_buffer_tags<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [T]ags in current buffer',
})
map('n', '<leader>ft', '<cmd>Telescope tags<cr>', { noremap = true, silent = true, desc = '[f]ind [t]ags globally' })
map('n', '<leader>fk', '<cmd>Telescope treesitter<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind [k] treesitter symbols',
})
map('n', '<leader>fO', '<cmd>Telescope vim_options<cr>', {
    noremap = true,
    silent = true,
    desc = '[f]ind neovim [o]ptions',
})
map('n', '<leader>gm', '<cmd>Gitsign blame_line<cr>', {
    noremap = true,
    silent = true,
    desc = '[g]it [m]essage from git blame',
})
map('n', '[g', '<cmd>Gitsign prev_hunk<cr>', { noremap = true, silent = true, desc = '[[g]it - previous hunk' })
map('n', ']g', '<cmd>Gitsign next_hunk<cr>', { noremap = true, silent = true, desc = '[]g]it - next hunk' })

map(
    'n',
    '<space>f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, " .. 'current_line_only = false })<cr>',
    { noremap = true, silent = true, desc = 'hop forward' }
)
map(
    'n',
    '<space>F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, " .. 'current_line_only = false })<cr>',
    { noremap = true, silent = true, desc = 'hop backward' }
)
map(
    'o',
    '<space>f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, " .. 'current_line_only = false, inclusive_jump = true })<cr>',
    { noremap = true, silent = true, desc = 'hop forward' }
)
map(
    'o',
    '<space>F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, "
        .. 'current_line_only = false, inclusive_jump = true })<cr>',
    { noremap = true, silent = true, desc = 'hop backward' }
)
map(
    '',
    '<space>t',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, " .. 'current_line_only = false })<cr>',
    { noremap = true, silent = true, desc = 'hop forward' }
)
map(
    '',
    '<space>T',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, " .. 'current_line_only = false })<cr>',
    { noremap = true, silent = true, desc = 'hop backward' }
)

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

-- TODO: enable if refactor is on
-- map('v', '<Leader>re', require('refactoring').refactor 'Extract Function', {
--     noremap = true,
--     silent = true,
--     expr = false,
-- })
-- map('v', '<Leader>rf', require('refactoring').refactor 'Extract Function To File', {
--     noremap = true,
--     silent = true,
--     expr = false,
-- })
-- map('v', '<Leader>rv', require('refactoring').refactor 'Extract Variable', {
--     noremap = true,
--     silent = true,
--     expr = false,
-- })
-- map('v', '<Leader>ri', require('refactoring').refactor 'Inline Variable', {
--     noremap = true,
--     silent = true,
--     expr = false,
-- })
-- map('n', '<Leader>ri', require('refactoring').refactor 'Inline Variable', {
--     noremap = true,
--     silent = true,
--     expr = false,
-- })
--
-- remap to open the Telescope refactoring menu in visual mode
-- map('v', '<leader>rr', require('telescope').extensions.refactoring.refactors(), { noremap = true })
