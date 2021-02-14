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
      'nvim-treesitter/nvim-treesitter'
      run = function() vim.cmd [[TSUpdate]] end
    }
    use {
      'nvim-treesitter/completion-treesitter',
      run = function() vim.cmd [[TSUpdate]] end
    }
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
    use 'rhysd/git-messenger.vim'
    use {'junegunn/fzf', run = './install --all' }     -- Fuzzy Searcher
    use {'junegunn/fzf.vim'}
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
