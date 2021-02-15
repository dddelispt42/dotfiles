-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  -- TODO: Maybe handle windows better?
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")
  print("( You'll need to restart now )")

  return
end

return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'

    local local_use = function(first, second)
      local plug_path, home
      if second == nil then
        plug_path = first
        home = 'heiko'
      else
        plug_path = second
        home = first
      end

      if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
        use("~/plugins/" .. plug_path)
      else
        use(string.format('%s/%s', home, plug_path))
      end
    end

    use 'nvim-telescope/telescope-frecency.nvim'
    use 'mhinz/vim-startify'
    use 'dstein64/vim-startuptime'
    use 'norcalli/nvim-colorizer.lua'
    use 'norcalli/nvim-terminal.lua'
    use 'romainl/vim-qf'
    use {
      'glacambre/firenvim',
      run = function()
        vim.fn['firenvim#install'](0)
      end
    }
    -- Pretty icons. Not necessarily required.
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'sjl/gundo.vim'
    use 'gyim/vim-boxdraw' -- Crazy good box drawing
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use 'justinmk/vim-syntax-extra'
    use 'elzr/vim-json'
    use 'pearofducks/ansible-vim'
    use 'cespare/vim-toml'
    use 'Glench/Vim-Jinja2-Syntax'
    use 'euclidianAce/BetterLua.vim'
    use 'neovim/nvim-lspconfig'
    use 'wbthomason/lsp-status.nvim'
    use 'haorenW1025/completion-nvim'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() vim.cmd [[TSUpdate]] end
    }
    use {
      'nvim-treesitter/completion-treesitter',
      run = function() vim.cmd [[TSUpdate]] end
    }
    use 'SirVer/ultisnips'
    use 'norcalli/snippets.nvim'
    use 'norcalli/ui.nvim'
    use 'liuchengxu/vista.vim'
    -- use 'puremourning/vimspector'
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use { 
      'theHamsta/nvim-dap-virtual-text',
      run = function()
        vim.g.dap_virtual_text = true
      end
    }
    use 'nvim-treesitter/playground'
    use 'justinmk/vim-dirvish'
    use 'godlygeek/tabular'        -- Quickly align text by pattern
    use 'tpope/vim-commentary'     -- Easily comment out lines or objects
    use 'tpope/vim-surround'       -- Surround text objects easily
    -- Floating windows are awesome :)
    -- used <leader>gm to see the related git commit msg
    use 'rhysd/git-messenger.vim'
    -- if executable('sk')
    --     Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
    --     Plug 'lotabout/skim.vim'
    --     command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
    -- else
        use {'junegunn/fzf', run = './install --all' }     -- Fuzzy Searcher
        use {'junegunn/fzf.vim'}
    -- endif
    -- use  'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    -- use 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeToggle' }
    -- use 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-rhubarb' -- required by fugitive to :Gbrowse
    use 'Raimondi/delimitMate'
    use 'Yggdroot/indentLine'
    -- Plug 'Shougo/vimproc.vim', {'do': g:make}
    -- Vim-Session
    -- Plug 'xolox/vim-misc'
    -- Plug 'xolox/vim-session'
    -- c/c++
    -- Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
    -- Plug 'ludwig/split-manpage.vim'
    -- html
    -- Plug 'tpope/vim-haml'
    -- " Plug 'mattn/emmet-vim'
    -- rust
    -- Plug 'racer-rust/vim-racer', { 'for': 'rust' }
    -- Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    -- Plug 'timonv/vim-cargo', { 'for': 'rust' }
    -- " TODO: get debugger working <06-12-20, Heiko Riemer> "
    -- Plug 'vim-scripts/Conque-GDB', { 'for': ['c', 'cpp', 'rust'] }
    -- see colorschemes http://bytefluent.com/vivify/
    use 'flazz/vim-colorschemes'
    use 'plasticboy/vim-markdown'
    use 'mzlogin/vim-markdown-toc'
    use 'ntpeters/vim-better-whitespace'
    -- Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    -- Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
    -- todo:slow Plug 'chrisbra/csv.vim'
    -- Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
    -- Plug 'joonty/vdebug', { 'for': 'python' }
    -- " todo:slow Plug 'ap/vim-css-color'
    -- " syntax for plantuml and make command
    use 'aklt/plantuml-syntax'
    -- " Plug 'sjurgemeyer/vim-plantuml', { 'for': 'plantuml' }
    use 'nathanalderson/yang.vim'
    -- " todo:slow Plug 'bling/vim-bufferline'
    -- " interesting but not yet configured
    -- Plug 'sjl/gundo.vim', { 'on': [] }
    -- " Git commit browser (:GV)
    -- Plug 'junegunn/gv.vim'
    -- " works with tabular to format markdown tables when pressing "|"
    -- " todo: fix Plug 'quentindecock/vim-cucumber-align-pipes'
    -- " immediate preview
    -- " Vimwiki - http://thedarnedestthing.com/vimwiki%20cheatsheet
    -- " Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
    use 'vimwiki/vimwiki'
    -- " Latex
    -- " Plug 'vim-latex/vim-latex', { 'for': 'tex' }
    -- " Plug 'lervag/vimtex'
    use 'donRaphaco/neotex'
    use 'benmills/vimux'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-speeddating'
    use 'easymotion/vim-easymotion'
    use 'vim-scripts/matchit.zip'
    -- " Plug 'rstacruz/sparkup'
    -- " Plug 'mjbrownie/hackertyper.vim'
    -- " Plug 'sirtaj/vim-openscad'
    -- Plug '907th/vim-auto-save'
    use 'will133/vim-dirdiff'
    use 'christoomey/vim-conflicted'
    use 'christoomey/vim-sort-motion'
    use 'christoomey/vim-tmux-navigator'
    use 'brooth/far.vim'
    -- " allows opening files at specific location - e.g. /tmp/bal:10:2
    -- Plug 'wsdjeg/vim-fetch'
    -- " Plug 'henrik/vim-open-url'
    use 'romainl/vim-cool'
    -- " TODO: buggy
    -- " Plug 'stsewd/gx-extended.vim'
    -- " better encryption plugin - requires: https://github.com/jedisct1/encpipe
    use 'hauleth/vim-encpipe'
    -- " floating windows
    use 'machakann/vim-highlightedyank'
    use 'voldikss/vim-floaterm'
    use 'stsewd/fzf-checkout.vim'
    -- " edit JIRA issues in vim
    -- use 'dddelispt42/vira', { 'do': './install.sh' }
    -- " automatically set the root directory
    use 'airblade/vim-rooter'

    -- " TODO: test this alternative to Ale/Ycm  <02-05-20, Heiko Riemer> "
    -- " Plug 'mattn/vim-lsp-settings'
    -- " Plug 'prabirshrestha/async.vim'
    -- " Plug 'prabirshrestha/asyncomplete-lsp.vim'
    -- " Plug 'prabirshrestha/asyncomplete.vim'
    -- " Plug 'prabirshrestha/vim-lsp'
    -- " Plug 'thomasfaingnaert/vim-lsp-ultisnips'

    --" Plug 'CoatiSoftware/vim-sourcetrail'

  end,
  config = {
    _display = {
      open_fn = function(name)
        -- Can only use plenary when we have our plugins.
        --  We can only get plenary when we don't have our plugins ;)
        local ok, float_win = pcall(function()
          return require('plenary.window.float').percentage_range_window(0.8, 0.8)
        end)

        if not ok then
          vim.cmd [[65vnew  [packer] ]]

          return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
        end

        local bufnr = float_win.bufnr
        local win = float_win.win_id

        vim.api.nvim_buf_set_name(bufnr, name)
        vim.api.nvim_win_set_option(win, 'winblend', 10)

        return win, bufnr
      end
    },
  }
}
