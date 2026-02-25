local TS = {}

TS.setup = function()
	require('nvim-treesitter').setup({})
	pcall(vim.treesitter.start)
	vim.api.nvim_create_autocmd('FileType', {
		callback = function(_)
			pcall(vim.treesitter.start)
		end
	})
end

return TS
