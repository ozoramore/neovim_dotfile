-- format.lua
-- author ozoramore
--
-- `Format` コマンドでバッファをフォーマットする。
-- LSPがインストールされている場合はLSPを利用してフォーマットできる

local FORMAT = {}

local function lsp()
	local buf = vim.api.nvim_get_current_buf()
	local clients_req = { bufnr = buf, method = 'textDocument/formatting' }
	local has_clients = #vim.lsp.get_clients(clients_req) ~= 0
	if has_clients then vim.lsp.buf.format({ async = true }) end
	return has_clients
end

local function native()
	local pos = vim.fn.getpos('.')
	vim.cmd.normal('gg=G')
	vim.fn.setpos('.', pos)
end

FORMAT.exec = function()
	if not lsp() then native() end
end

return FORMAT
