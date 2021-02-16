local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- global options
o.swapfile = true
-- o.dir = '/tmp'
o.dir = '~/.cache/vim/swap'
o.textwidth=119
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
o.hidden = true
o.scrolloff=3
-- o.spell!
o.smartcase = true
o.inccommand = 'nosplit'
o.termguicolors = true
o.path = o.path .. '**'
o.splitbelow = true
o.splitright = true
o.tags='ctags,.git/ctags,.svn/ctags,../ctags,../.git/ctags,../.svn/ctags,../../ctags,../../.git/ctags,../../.svn/ctags,../../../ctags,../../../.git/ctags,../../../.svn/ctags;'
o.list = true
o.listchars='nbsp:¬,tab:»·,trail:·'
o.wildignore = o.wildignore .. '*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite'
o.wildignore = o.wildignore .. '*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.jar,*.png,*.class,*.jpg,*.pdf,*.pst,*.ppt,*.doc,*.xls,*.pptx,*.docx,*.xlsx,*.ico,*.bmp,*.gif,*.7z,*.deb,*.rpm,*.dot,*.exe,*.dll,*.aps,*.chm,*.dat,*.dump,*.mp3,*.mkv,*.mp4 ,*.m4a,*.gz,*.tar,*.tgz,*.mdb,*.msg,*.odt,*.oft,*.pdb,*.ppm,*.pps,*.pub,*.mobi,*.rtf,*.stackdump,*.dump,*.ttf,*.otf,*.tmp,*.temp,*.zip'
o.tags='tags,.git/tags,.svn/tags,../tags,../.git/tags,../.svn/tags,../../tags,../../.git/tags,../../.svn/tags,../../../tags,../../../.git/tags,../../../.svn/tags;'
o.shortmess = o.shortmess .. 'c'
o.completeopt = 'menuone,noinsert,noselect,preview'
o.signcolumn = 'yes'
o.updatetime = 300

-- window-local options
wo.number = true
wo.relativenumber = true
wo.wrap = false
-- wo.showmatch = true
-- wo.colorcolumn = 100
wo.cursorline = true

-- buffer-local options
bo.expandtab = true
bo.tabstop=4
bo.softtabstop=4
bo.shiftwidth=4

--[[
TODO: setstatusline with fugitive
TODO: clipboard
]]
vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme molokai')
-- vim.cmd('colorscheme anotherdark')
-- vim.cmd('colorscheme zenburn')
-- vim.cmd('colorscheme wombat256')
-- vim.cmd('colorscheme whitedust')
-- vim.cmd('colorscheme tutticolori')
-- vim.cmd('colorscheme soso')
-- vim.cmd('colorscheme simpleandfriendly')
-- vim.cmd('colorscheme evening')
-- vim.cmd('colorscheme asmdev')
vim.cmd('filetype plugin indent on')
vim.cmd('set spell!')

local map = vim.api.nvim_set_keymap

-- g...git; f...find; s...session; t...terminal;

-- map the leader key
map('n', ',', '', {})
vim.g.mapleader = ','  -- 'vim.g' sets global variables
options = { noremap = true }
-- General
map('i', 'jk', '<esc>', options)
map('n', 'n', 'nzzzv', options)
map('n', 'N', 'Nzzzv', options)
map('n', 'Q', '@@', options)
map('c', 'W!', 'w!', options)
map('c', 'Q!', 'q!', options)
map('c', 'Qa!', 'qa!', options)
map('c', 'W', 'w', options)
map('c', 'Q', 'Q', options)
-- Buffer
map('n', '<Leader>h', ':<C-u>split<CR>', options)
map('n', '<Leader>v', ':<C-u>vsplit<CR>', options)
map('n', '<leader>z', ':bp<CR>', options)
map('n', '<leader>x', ':bn<CR>', options)
map('n', '<leader>c', ':bd<CR>', options)
-- GIT
map('n', '<Leader>ga', ':Gwrite<CR>', options)
map('n', '<Leader>gc', ':Gcommit<CR>', options)
map('n', '<Leader>gsh', ':Gpush<CR>', options)
map('n', '<Leader>gll', ':Gpull<CR>', options)
map('n', '<Leader>gs', ':Gstatus<CR>', options)
map('n', '<Leader>gbl', ':Gblame<CR> noremap <Leader>gd :Gvdiff<CR>', options)
-- map('n', '<Leader>gr', ':Gremove<CR>', options)
map('n', '<Leader>gbr', ':GBranches<CR>', options)
map('n', '<Leader>gt', ':GTags<CR>', options)
-- session management
map('n', '<leader>so', ':OpenSession<Space>', options)
map('n', '<leader>ss', ':SaveSession<Space>', options)
map('n', '<leader>sd', ':DeleteSession<CR>', options)
map('n', '<leader>sc', ':CloseSession<CR>', options)
-- Vista
map('n', '<Leader>tb', ':Vista!!<CR>', options)
-- Vmap for maintain Visual Mode after shifting > and <
map('n', '<', '<gv', options)
map('v', '>', '>gv', options)
-- Move visual block
map('v', 'J', ':m >+1<CR>gv=gv', options)
map('v', 'K', ':m <-2<CR>gv=gv', options)
-- Open current line on GitHub
map('n', '<Leader>o', ':.Gbrowse<CR>', options)
-- jump between buffers in normal mode
map('n', '<c-h>', '<c-w>h', options)
map('n', '<c-j>', '<c-w>j', options)
map('n', '<c-k>', '<c-w>k', options)
map('n', '<c-l>', '<c-w>l', options)
-- jump between buffers in visual mode
map('x', '<c-h>', '<c-w>h', options)
map('x', '<c-j>', '<c-w>j', options)
map('x', '<c-k>', '<c-w>k', options)
map('x', '<c-l>', '<c-w>l', options)
-- remove ^M from dos files
map('n', '<leader>m', ':e ++ff=dos<cr>', options)
-- move vertically by visual line
map('n', 'j', 'gj', options)
map('n', 'k', 'gk', options)
-- highlight last inserted text
map('n', 'gV', '`[v`]', options)
-- Open applications
map('n', '<leader>s', ':Snippets<CR>', options)
-- Open applications
map('n', '<c-n>', ':NvimTreeToggle<CR>', options)
-- Fuzzy
map('n', '<Leader>f', ':GFiles<CR>', options)
map('n', '<Leader>F', ':Files<CR>', options)
map('n', '<leader>e', ':FZF -m<CR>', options)
map('n', '<Leader>b', ':Buffers<CR>', options)
map('n', '<Leader>y', ':History<CR>', options)
map('n', '<Leader>t', ':BTags<CR>', options)
map('n', '<Leader>T', ':Tags<CR>', options)
map('n', '<Leader>l', ':BLines<CR>', options)
map('n', '<Leader>L', ':Lines<CR>', options)
map('n', "<Leader>'", 'Marks<CR>', options)
map('n', '<Leader>a', ':Rg<Space><CR>', options)
map('n', '<Leader>H', ':Helptags!<CR>', options)
map('n', '<Leader>C', ':Commands<CR>', options)
map('n', '<Leader>:', ':History:<CR>', options)
map('n', '<Leader>/', ':History/<CR>', options)
map('n', '<Leader>M', ':Maps<CR>', options)
map('n', '<Leader>S', ':Filetypes<CR>', options)

-- LSP
map('n', 'gh', ':Lspsaga lsp_finder<CR>', options)
map('n', '<leader>ca', ':Lspsaga code_action<CR>', options)
map('v', '<leader>ca', ':<C-U>Lspsaga range_code_action<CR>', options)
map('n', 'K', ':Lspsaga hover_doc<CR>', options)
map('n', 'gS', ':Lspsaga signature_help<CR>', options)
map('n', 'gR', ':Lspsaga rename<CR>', options)
map('n', 'gp', ':Lspsaga preview_definition<CR>', options)
map('n', '<leader>cd', ':Lspsaga show_line_diagnostics<CR>', options)
map('n', 'e[', ':Lspsaga diagnostic_jump_next<CR>', options)
map('n', 'e]', ':Lspsaga diagnostic_jump_prev<CR>', options)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
-- rust-analyzer does not yet support goto declaration - re-mapped `gd` to definition
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
-- map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
-- map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', options)

-- Completion (nvim-comple)
map('i', '<expr> <C-Space>', 'compe#complete()', options)
map('i', '<expr> <CR>', "compe#confirm('<CR>')", options)
map('i', '<expr> <C-e>', "compe#close('<C-e>')", options)
map('i', '<expr> <C-f>', "compe#scroll({ 'delta': +4 })", options)
map('i', '<expr> <C-d>', "compe#scroll({ 'delta': -4 })", options)


-- vim.cmd('command! FixWhitespace :%s/\s\+$//e')

-- place me somewhere in your init.lua
-- local focus = require('focus')
-- focus.width = 120
-- focus.height = 40

require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true
  }
}

-- Formatter
require('formatter').setup({
  logging = false,
  filetype = {
    css = {
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
    html = {
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
    yaml = {
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
    javascript = {
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
    go = {
      function()
        return {
          exe = "gofmt",
          args = {""},
          stdin = true
        }
      end
    },
    sh = {
      function()
        return {
          exe = "shfmt",
          stdin = true
        }
      end
    },
    python = {
      function()
        return {
          exe = "black",
          args = {""},
          stdin = true
        }
      end
    },
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
    lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
  }
})
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
augroup END
]], true)
