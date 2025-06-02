-- format.lua
-- author ozoramore
--
-- `Format` コマンドでバッファをフォーマットする。
-- LSPがインストールされている場合はLSPを利用してフォーマットできる

local M = {}

function M.lsp()
	local has_clients = #vim.lsp.get_clients({ method = 'textDocument/formatting' }) ~= 0
	if has_clients then vim.lsp.buf.format({ async = true }) end
	return has_clients
end

M.native = function()
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
