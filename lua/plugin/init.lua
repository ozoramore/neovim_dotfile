local M = {}

local load = function(src, setup)
	local load = function()
		if src then require('plugin.mini').deps.add({ source = src }) end
		if setup then setup() end
	end
	require('plugin.mini').deps.now(load)
end

M.load = load

M.setup = function()
	require('plugin.mini').packadd()
	require('plugin.fep').setup()
	require('plugin.mini').setup()
	load('folke/styler.nvim', require('plugin.styler').setup)
	load('cameron-wags/rainbow_csv.nvim', require('plugin.rainbow_csv').setup)
	load('lewis6991/gitsigns.nvim', require('plugin.gitsigns').setup)
	load('luukvbaal/statuscol.nvim', require('plugin.statuscol').setup)
	load('ozoramore/nvimpc.lua', require('plugin.mpc').setup)
	if vim.fn.has('unix') == 1 then
		load('mfussenegger/nvim-dap', require('plugin.dap').setup)
		load('nvim-treesitter/nvim-treesitter', require('plugin.treesitter').setup)
		load('neovim/nvim-lspconfig', require('plugin.lsp').setup)
	end
end

return M
