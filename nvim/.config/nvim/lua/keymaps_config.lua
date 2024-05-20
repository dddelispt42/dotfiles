---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

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
--   b...buffer
--   c...merge conflicts
--   d...debug
--   f...find (Telescope)
--   g...git
--   h...hunk
--   l...LSP stuff
--   s...session
--   t...terminal/test
--   w...window

-- Shorten function name
local map = vim.keymap.set
-- Keymaps for better default experience See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map({ 'n', 'v' }, ',', '<Nop>', { silent = true })
-- General
map('n', '<esc>', ':nohlsearch<cr><esc>', { noremap = true, silent = true })
map('i', 'jk', '<esc>', { noremap = true, silent = true })
map('t', 'jk', '<c-\\><c-n>', { noremap = true, silent = true })
map('n', 'n', 'nzzzv', { noremap = true, silent = true })
map('n', 'N', 'Nzzzv', { noremap = true, silent = true })
map('n', 'Q', '@@j', { noremap = true, silent = true })
map('x', 'Q', ':norm @@<cr>', { noremap = true, silent = true })
map('c', 'W!', 'w !doas tee %', { noremap = true, silent = true }) -- write as root
map('c', 'Q!', 'q!', { noremap = true, silent = true })
map('c', 'Qa!', 'qa!', { noremap = true, silent = true })
map('i', '<c-bs>', '<c-w>', { noremap = true, silent = true }) -- ctrl-backspace to delete previous word
map('i', '<c-h>', '<c-w>', { noremap = true, silent = true }) -- ctrl-backspace to delete previous word
-- Move visual block
map({ 'n', 'v' }, '<A-j>', ':m +1<CR>gv=gv', { noremap = true, silent = true })
map({ 'n', 'v' }, '<A-k>', ':m -2<CR>gv=gv', { noremap = true, silent = true })
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
map('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
-- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
-- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- remove ^M from dos files
-- map("n", "<leader>m", ":e ++ff=dos<cr>", { noremap = true, silent = true })
-- move vertically by visual line
-- Remap for dealing with word wrap
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, '<up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ 'n', 'x' }, '<down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- highlight last inserted text
map('n', 'gV', '`[v`]', { noremap = true, silent = true })
-- Buffer
-- map('n', '<leader>h', ':<C-u>split<CR>', { noremap = true, silent = true })
-- map('n', '<leader>v', ':<C-u>vsplit<CR>', { noremap = true, silent = true })
map('n', '<S-l>', ':bnext<CR>', { noremap = true, silent = true })
map('n', '<S-h>', ':bprevious<CR>', { noremap = true, silent = true })

-- from unimpaired
map('n', '[a', ':previous<CR>', { noremap = true, silent = true, desc = 'previous [a]rg' })
map('n', ']a', ':next<CR>', { noremap = true, silent = true, desc = 'next [a]rg' })
map('n', '[A', ':first<CR>', { noremap = true, silent = true, desc = 'first [A]rg' })
map('n', ']A', ':last<CR>', { noremap = true, silent = true, desc = 'last [A]rg' })
map('n', '[b', ':bprevious<CR>', { noremap = true, silent = true, desc = 'previous [b]uffer' })
map('n', ']b', ':bnext<CR>', { noremap = true, silent = true, desc = 'next [b]uffer' })
map('n', '[B', ':bfirst<CR>', { noremap = true, silent = true, desc = 'first [b]uffer' })
map('n', ']B', ':blast<CR>', { noremap = true, silent = true, desc = 'last [b]uffer' })
map('n', '[l', ':bprev<CR>zz', { noremap = true, silent = true, desc = 'previous [l]ocation list item' })
map('n', ']l', ':bnext<CR>zz', { noremap = true, silent = true, desc = 'next [l]ocation list item' })
map('n', '[L', ':bfirst<CR>zz', { noremap = true, silent = true, desc = 'first [l]ocation list item' })
map('n', ']L', ':blast<CR>zz', { noremap = true, silent = true, desc = 'last [l]ocation list item' })
map('n', '[q', ':cprev<CR>zz', { noremap = true, silent = true, desc = 'previous [q]uick list item' })
map('n', ']q', ':cnext<CR>zz', { noremap = true, silent = true, desc = 'next [q]uick list item' })
map('n', '[Q', ':cfirst<CR>zz', { noremap = true, silent = true, desc = 'first [q]uick list item' })
map('n', ']Q', ':clast<CR>zz', { noremap = true, silent = true, desc = 'last [q]uick list item' })
map('n', '[<C-Q>', ':cpfile<CR>zz', { noremap = true, silent = true, desc = 'first [q]uick error' })
map('n', ']<C-Q>', ':cnfile<CR>zz', { noremap = true, silent = true, desc = 'next [q]uick error' })
map('n', '[T', ':tprev<CR>', { noremap = true, silent = true, desc = 'previous [t]ab' })
map('n', ']T', ':tnext<CR>', { noremap = true, silent = true, desc = 'next [t]ag' })
-- map('n', '[T', ':tabprev<CR>', { noremap = true, silent = true, desc = 'previous [t]ab' })
-- map('n', ']T', ':tabnext<CR>', { noremap = true, silent = true, desc = 'next [t]ab' })
map('n', '[t', function()
    require('todo-comments').jump_prev()
end, { noremap = true, silent = true, desc = 'prev [t]todo' })
map('n', ']t', function()
    require('todo-comments').jump_next()
end, { noremap = true, silent = true, desc = 'next [t]todo' })
map('n', '[ob', ':set background=dark<CR>', { noremap = true, silent = true, desc = '[o]ption [b]ackground dark' })
map('n', ']ob', ':set background=light<CR>', { noremap = true, silent = true, desc = '[o]ption [b]ackground light' })
map('n', '[oc', ':set nocursorline<CR>', { noremap = true, silent = true, desc = '[o]ption no [c]ursorline' })
map('n', ']oc', ':set cursorline<CR>', { noremap = true, silent = true, desc = '[o]ption [c]ursorline' })
map('n', '[od', ':diffthis<CR>', { noremap = true, silent = true, desc = '[o]peration: diffthis' })
map('n', ']od', ':diffoff<CR>', { noremap = true, silent = true, desc = '[o]peration: diffoff' })
map('n', '[oh', ':set nohlsearch<CR>', { noremap = true, silent = true, desc = '[o]ption no [h]lsearch' })
map('n', ']oh', ':set hlsearch<CR>', { noremap = true, silent = true, desc = '[o]ption [h]lsearch' })
map('n', '[oi', ':set noignorecase<CR>', { noremap = true, silent = true, desc = '[o]ption no [i]gnorecase' })
map('n', ']oi', ':set ignorecase<CR>', { noremap = true, silent = true, desc = '[o]ption [i]gnorecase' })
map('n', '[ol', ':set nolist<CR>', { noremap = true, silent = true, desc = '[o]ption no [l]ist' })
map('n', ']ol', ':set list<CR>', { noremap = true, silent = true, desc = '[o]ption [l]ist' })
map('n', '[on', ':set nonumber<CR>', { noremap = true, silent = true, desc = '[o]ption no [n]umber' })
map('n', ']on', ':set number<CR>', { noremap = true, silent = true, desc = '[o]ption [n]umber' })
map('n', '[or', ':set norelativenumber<CR>', { noremap = true, silent = true, desc = '[o]ption no [r]elativenumber' })
map('n', ']or', ':set relativenumber<CR>', { noremap = true, silent = true, desc = '[o]ption [r]elativenumber' })
map('n', '[os', ':set nospell<CR>', { noremap = true, silent = true, desc = '[o]ption no [s]pell' })
map('n', ']os', ':set spell<CR>', { noremap = true, silent = true, desc = '[o]ption [s]pell' })
map('n', '[ot', ':set colorcolumn=0<CR>', { noremap = true, silent = true, desc = '[o]ption no [t]colorcolumn' })
map('n', ']ot', ':set colorcolumn=80<CR>', { noremap = true, silent = true, desc = '[o]ption [t]colorcolumn' })
map('n', '[ou', ':set nocursorcolumn<CR>', { noremap = true, silent = true, desc = '[o]ption no c[u]rsorcolumn' })
map('n', ']ou', ':set cursorcolumn<CR>', { noremap = true, silent = true, desc = '[o]ption c[u]rsorcolumn' })
map('n', '[ov', ':set novirtualedit<CR>', { noremap = true, silent = true, desc = '[o]ption no [v]irtualedit' })
map('n', ']ov', ':set virtualedit<CR>', { noremap = true, silent = true, desc = '[o]ption [v]irtualedit' })
map('n', '[ow', ':set nowrap<CR>', { noremap = true, silent = true, desc = '[o]ption no [w]rap' })
map('n', ']ow', ':set wrap<CR>', { noremap = true, silent = true, desc = '[o]ption [w]rap' })
map('n', '[ox', ':set nocursorline nocursorcolumn<CR>', { noremap = true, silent = true, desc = '[o]ption no [x]=cursor(line,column)' })
map('n', ']ox', ':set cursorline cursorcolumn<CR>', { noremap = true, silent = true, desc = '[o]ption [x]=cursor(line,column)' })
map('n', '[oD', ':lua vim.diagnostic.disable()<CR>', { noremap = true, silent = true, desc = '[o]ption no [D]iagnostics' })
map('n', ']oD', ':lua vim.diagnostic.enable()<CR>', { noremap = true, silent = true, desc = '[o]ption [D]iagnostics' })

local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go { severity = severity }
    end
end
map('n', '[d', diagnostic_goto(false), { desc = 'Prev [D]iagnostic' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next [D]iagnostic' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev [E]rror' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next [E]rror' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev [W]arning' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next [W]arning' })

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
-- Tagbar/Aerial
map('n', '<leader>tb', ':AerialToggle!<CR>', { noremap = true, silent = true, desc = '[t]ag [b]ar' })
map('n', '<leader>tB', ':AerialNavToggle<CR>', { noremap = true, silent = true, desc = '[t]ag [b]ar navigation' })
-- Merge conflicts
map('n', '<leader>cr', ':diffg RE<CR>', { noremap = true, silent = true, desc = '[m]erge selecting [r]emote' })
map('n', '<leader>cb', ':diffg BA<CR>', { noremap = true, silent = true, desc = '[m]erge selecting [b]ase' })
map('n', '<leader>cl', ':diffg LO<CR>', { noremap = true, silent = true, desc = '[m]erge selecting [l]ocal' })

-- LSP
-- map('n', '<leader>la', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = '[l]sp code [a]ction' })
map('n', '<leader>la', '<cmd>Lspsaga code_action<cr>', { noremap = true, silent = true, desc = '[l]sp code [a]ction' })
-- map('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = '[K] ... hover' })
map('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { noremap = true, silent = true, desc = '[K] ... hover' })
map('n', '<leader>lS', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = '[l]sp [S]ignature help' })
-- map('n', '<leader>lR', vim.lsp.buf.rename, { noremap = true, silent = true, desc = '[l]sp [R]ename' })
map('n', '<leader>lR', '<cmd>Lspsaga rename<cr>', { noremap = true, silent = true, desc = '[l]sp [R]ename' })
map('n', '<leader>le', vim.lsp.diagnostic.get_line_diagnostics, {
    noremap = true,
    silent = true,
    desc = '[l]sp [e]rror diagnostic',
})
map('n', '[e', vim.diagnostic.goto_prev, { noremap = true, silent = true })
map('n', ']e', vim.diagnostic.goto_next, { noremap = true, silent = true })
map('n', '<leader>lh', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { noremap = true, silent = true, desc = '[l]sp [h]int (inline)' })
map('n', '<leader>lr', vim.lsp.buf.references, { noremap = true, silent = true, desc = '[l]sp [r]eferences' })
-- map('n', '<leader>ld', vim.lsp.buf.definition, { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
-- map('n', '<leader>ld', "<cmd>Lspsaga peek_definition<cr>", { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
map('n', '<leader>ld', "<cmd>Lspsaga goto_definition<cr>", { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
map('n', '<leader>ld', '<cmd>Lspsaga peek_definition<cr>', { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
map('n', '<leader>lx', function()
    if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end, { noremap = true, silent = true, desc = '[l]sp [x] toggle diagnostics' })
map('n', '<leader>lr', vim.lsp.buf.references, { noremap = true, silent = true, desc = '[l]sp [r]eferences' })
-- map('n', '<leader>ld', vim.lsp.buf.definition, { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
-- map('n', '<leader>ld', "<cmd>Lspsaga peek_definition<cr>", { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
map('n', '<leader>ld', '<cmd>Lspsaga goto_definition<cr>', { noremap = true, silent = true, desc = '[l]sp [d]efinition' })
map('n', '<leader>lD', vim.lsp.buf.declaration, { noremap = true, silent = true, desc = '[l]sp [D]eclaration' })
map('n', '<leader>li', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = '[l]sp [i]implementation' })
-- map('n', '<leader>lI', vim.lsp.buf.incoming_calls, { noremap = true, silent = true, desc = '[l]sp [I]ncoming calls' })
map('n', '<leader>lI', '<cmd>Lspsaga incoming_calls<cr>', { noremap = true, silent = true, desc = '[l]sp [I]ncoming calls' })
-- map('n', '<leader>lO', vim.lsp.buf.outgoing_calls, { noremap = true, silent = true, desc = '[l]sp [O]outgoing calls' })
map('n', '<leader>lO', '<cmd>Lspsaga outgoing_calls<cr>', { noremap = true, silent = true, desc = '[l]sp [O]outgoing calls' })
-- map('n', '<leader>lt', vim.lsp.buf.type_definition, { noremap = true, silent = true, desc = '[l]sp [t]ype definition' })
map('n', '<leader>lt', '<cmd>Lsapsaga peek_type_definition<cr>', { noremap = true, silent = true, desc = '[l]sp [t]ype definition' })
map('n', '<leader>lF', '<cmd>Lspsaga finder tyd+def+ref+imp<cr>', { noremap = true, silent = true, desc = '[l]sp [F]inder' })
map('n', '<leader>lB', '<cmd>Lspsaga outline<cr>', { noremap = true, silent = true, desc = '[l]sp [B]ar w/ infos' })
map({ 'n', 't' }, '<A-t>', '<cmd>Lspsaga term_toggle<cr>', { noremap = true, silent = true, desc = '[l]sp [t]erminal toggle' })
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format { timeout_ms = 10000 }<cr>', { noremap = true, silent = true, desc = '[l]sp [f]ormat' })
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
map('n', '<leader>gd', ':DiffviewOpen<CR>', { noremap = true, silent = true, desc = '[g]it [d]iff' })
map('n', '<leader>gh', ':DiffviewFileHistory<CR>', { noremap = true, silent = true, desc = '[g]it [h]istory diff' })
map('n', '<leader>gc', ':DiffviewClose<CR>', { noremap = true, silent = true, desc = '[g]it [c]lose diff view' })

map('n', '<leader>gm', '<cmd>Gitsign blame_line(full=true)<cr>', {
    noremap = true,
    silent = true,
    desc = '[g]it [m]essage from git blame',
})

-- Hunks
-- Navigation
map('n', '[g', '<cmd>Gitsign prev_hunk<cr>', { noremap = true, silent = true, desc = '[[g]it - previous hunk' })
map('n', ']g', '<cmd>Gitsign next_hunk<cr>', { noremap = true, silent = true, desc = '[]g]it - next hunk' })
-- Actions
map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>hB', '<cmd>Gitsigns toggle_current_line_blame<CR>')
map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
map('n', '<leader>h-', '<cmd>Gitsigns toggle_deleted<CR>')
-- Text object
map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')

-- Trouble
map('n', '<leader>xx', '<cmd>Trouble<cr>', { silent = true, noremap = true, desc = '[x]Trouble [x]toggle' })
map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', { silent = true, noremap = true, desc = '[x]Trouble [w]orkspace' })
map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', { silent = true, noremap = true, desc = '[x]Trouble [d]ocument' })
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { silent = true, noremap = true, desc = '[x]Trouble [l]ocation list' })
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true, desc = '[x]Trouble [q]uicklist' })
map('n', '<leader>xt', '<cmd>TodoTrouble<cr>', { silent = true, noremap = true, desc = '[x]Trouble [t]odos' })
map('n', 'gR', '<cmd>Trouble lsp_references<cr>', { silent = true, noremap = true, desc = '[x]Trouble [R]references' })

-- GUI mode - zooms
map('n', '<C-ScrollWheelUp>', '<cmd>GUIFontSizeUp<CR>', { silent = true, noremap = true })
map('n', '<C-ScrollWheelDown>', '<cmd>GUIFontSizeDown<CR>', { silent = true, noremap = true })
map('i', '<C-ScrollWheelUp>', '<cmd>GUIFontSizeUp<CR>', { silent = true, noremap = true })
map('i', '<C-ScrollWheelDown>', '<cmd>GUIFontSizeDown<CR>', { silent = true, noremap = true })

-- Debugging
-- Commented shortcuts are in debug config file
map('n', '<leader>dc', '<cmd>DapContinue<cr>', { noremap = true, silent = true, desc = '[d]AP [c]ontinue' })
map('n', '<leader>di', '<cmd>DapStepInto<cr>', { noremap = true, silent = true, desc = '[d]AP step [i]nto' })
map('n', '<leader>do', '<cmd>DapStepOver<cr>', { noremap = true, silent = true, desc = '[d]AP step [o]ver' })
map('n', '<leader>du', '<cmd>DapStepOut<cr>', { noremap = true, silent = true, desc = '[d]AP step o[u]t' })
map('n', '<leader>dr', '<cmd>DapToggleRepl<cr>', { noremap = true, silent = true, desc = '[d]AP toggle [r]epl' })
map('n', '<leader>dl', '<cmd>DapShowLog<cr>', { noremap = true, silent = true, desc = '[d]AP show [l]og' })
map('n', '<leader>dt', '<cmd>DapTerminate<cr>', { noremap = true, silent = true, desc = '[d]AP [t]erminate' })
map('n', '<leader>dm', '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>', {
    noremap = true,
    silent = true,
    desc = '[d]AP set log point [m]essage',
})
map('n', '<leader>dR', 'run_last()<cr>', { noremap = true, silent = true, desc = '[d]AP [R]un last' })
map('n', '<leader>dC', '<cmd>Telescope dap commands<cr>', { noremap = true, silent = true, desc = '[d]AP [C]ommands' })
map('n', '<leader>dF', '<cmd>Telescope dap configurations<cr>', { noremap = true, silent = true, desc = '[d]AP con[F]iguration' })
map('n', '<leader>dL', '<cmd>Telescope dap list_breakpoints<cr>', { noremap = true, silent = true, desc = '[d]AP [L]ist breakpoints' })
map('n', '<leader>dV', '<cmd>Telescope dap variables<cr>', { noremap = true, silent = true, desc = '[d]AP list [v]ariables' })
map('n', '<leader>d?', function()
    require('dapui').eval(nil, { enter = true })
end, { noremap = true, silent = true, desc = '[d]AP [?] eval var under cursor' })

-- Tree SJ
map('n', '<leader>J', function()
    require('treesj').toggle { split = { recursive = true } }
end, { noremap = true, silent = true, desc = '[J]oin line toggle - syntax aware' })

-- TODO: check neotest and use leader-t etc
