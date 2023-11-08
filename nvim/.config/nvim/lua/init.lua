-- luacheck: globals vim
---@diagnostic disable: undefined-global

-- Define leader key
vim.g.mapleader = ' ' -- 'vim.g' sets global variables
vim.g.maplocalleader = ' '

require 'general_config'
require 'plugins_config'
require 'treesitter_config'
require 'keymaps_config'
require 'telescope_config'
require 'utils_config'
require 'git_config'
require 'gitsigns_config'
require 'completion_config'
require 'colors_config'
require 'bufferline_config'
require 'cursorline_config'
require 'orgmode_config'
require 'null-ls_config'
require 'lsp_config'
require 'debug_config'
require 'rest_config'
require 'plantuml_config'
require 'refactoring_config'
require 'notify_config'
require 'test_config'
-- require 'codeium_config'
