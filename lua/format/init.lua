local M = {}

local function has_lsp_format()
	local lsp_client = vim.lsp.get_clients({ method = 'textDocument/formatting' })
	return #lsp_client ~= 0
end

function M.lsp()
	local result = has_lsp_format()
	if result then vim.lsp.buf.format() end
	return result
end

M.native_format = function()
	local pos = vim.fn.getpos('.')
	vim.cmd.normal('gg=G')
	vim.fn.setpos('.', pos)
end

M.exec = function()
	if not M.lsp() then M.native() end
end

M.setup = function()
	vim.api.nvim_create_user_command('Format', M.exec, {})
end
return M
