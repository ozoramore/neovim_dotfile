local M = {}

M.setup = function()
	vim.api.nvim_create_autocmd('FileType', {
		callback = function(_)
			pcall(vim.treesitter.start)
		end
	})
end

return M
