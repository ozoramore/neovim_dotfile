local M = {}

M.native = function()
	local pos = vim.fn.getpos('.')
	vim.cmd.normal('gg=G')
	vim.fn.setpos('.', pos)
end

M.exec = function()
	if not require('lsp').format() then M.native() end
end

M.setup = function()
	vim.api.nvim_create_user_command('Format', M.exec, {})
end
return M
