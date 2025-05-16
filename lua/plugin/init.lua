require('plugin.loader').setup()

require('plugin.im').setup()
require('plugin.mini').setup()

local load = require('plugin.loader').load

local styles = require('plugin.styles')
load('folke/styler.nvim', styles.styler)
load('cameron-wags/rainbow_csv.nvim', styles.rainbow_csv)
load('lewis6991/gitsigns.nvim', styles.gitsigns)
load('luukvbaal/statuscol.nvim', styles.statuscol)

local for_linux = require('plugin.for_linux')

load('neovim/nvim-lspconfig', for_linux.lspconfig)
load('mfussenegger/nvim-dap', for_linux.nvim_dap)
load('nvim-treesitter/nvim-treesitter', for_linux.treesitter)
