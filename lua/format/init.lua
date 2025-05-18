local M = {}
M.lsp = function()
	vim.lsp.buf.format({ async = true })
end

M.native = function()
	local pos = vim.fn.getpos('.')
	vim.cmd.normal('gg=G')
	vim.fn.setpos('.', pos)
end

M.exec = function()
	local lsp_client = vim.lsp.get_clients({ bufnr = 0 })[1]
	local has_lsp_format = lsp_client and lsp_client:supports_method('textDocument/formatting')
	if has_lsp_format then
		M.lsp()
	else
		M.native()
	end
end

M.setup = function()
	vim.api.nvim_create_user_command('Format', M.exec, {})
end
return M
