local M = {}

function M.set(buf)
	local has_parser = vim.treesitter.get_parser(buf, nil, { error = false })
	if has_parser then vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' end
	return has_parser
end

return M
