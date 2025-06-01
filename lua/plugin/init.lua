local M = {}

local load = function(src, setup)
	local load = function()
		if src then require('plugin.mini').deps.add({ source = src }) end
		if setup then setup() end
	end
	require('plugin.mini').deps.now(load)
end

M.load = load

local function styles_setup()
	local styles = require('plugin.styles')
	load('folke/styler.nvim', styles.styler)
	load('cameron-wags/rainbow_csv.nvim', styles.rainbow_csv)
	load('lewis6991/gitsigns.nvim', styles.gitsigns)
	load('luukvbaal/statuscol.nvim', styles.statuscol)
end

local function unix_setup()
	if vim.fn.has('unix') ~= 1 then return nil end
	local unix = require('plugin.unix')
	load('mfussenegger/nvim-dap', unix.nvim_dap)
	load('nvim-treesitter/nvim-treesitter', unix.treesitter)
end

M.setup = function()
	require('plugin.mini').packadd()
	require('plugin.fep').setup()
	require('plugin.mini').setup()
	styles_setup()
	unix_setup()
	load('folke/styler.nvim', require('plugin.styler').setup)
	load('cameron-wags/rainbow_csv.nvim', require('plugin.rainbow_csv').setup)
	load('lewis6991/gitsigns.nvim', require('plugin.gitsigns').setup)
	load('luukvbaal/statuscol.nvim', require('plugin.statuscol').setup)
	load('ozoramore/nvimpc.lua', require('plugin.mpc').setup)
end

return M
