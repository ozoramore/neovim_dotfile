local M = {}

local function set_treesitter(buf)
	local has_parser = vim.treesitter.get_parser(buf, nil, { error = false })
	if has_parser then vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' end
	return has_parser
end

M.setup = function()
	vim.api.nvim_create_autocmd('BufWinEnter', {
		callback = function(args)
			if require('fold.lsp').set(args.buf) then return end
			set_treesitter(args.buf)
		end
	})
end

return M
