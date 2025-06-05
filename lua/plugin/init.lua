local PLUGIN = {}

PLUGIN.load = function(src, setup)
	local _load = function()
		if src then require('plugin.mini').deps.add({ source = src }) end
		if setup then setup() end
	end
	require('plugin.mini').deps.now(_load)
end

PLUGIN.setup = function() -- plugin設定
	require('plugin.mini').setup()
	require('plugin.fep').setup()

	PLUGIN.load('folke/styler.nvim', require('plugin.styler').setup)
	PLUGIN.load('lewis6991/gitsigns.nvim', require('plugin.gitsigns').setup)
	PLUGIN.load('luukvbaal/statuscol.nvim', require('plugin.statuscol').setup)

	PLUGIN.load('ozoramore/nvimpc.lua', require('plugin.mpc').setup)

	if vim.fn.has('unix') == 1 then
		PLUGIN.load('mfussenegger/nvim-dap', require('plugin.dap').setup)
		PLUGIN.load('nvim-treesitter/nvim-treesitter', require('plugin.treesitter').setup)
		PLUGIN.load('neovim/nvim-lspconfig', require('plugin.lsp').setup)
	end
end

return PLUGIN
