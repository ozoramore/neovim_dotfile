local M = {}

M.put = function(lines)
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end

M.get = function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
	local n = col + 1
	return string.sub(line, n + vim.str_utf_start(line, n), n + vim.str_utf_end(line, n))
end

return M
