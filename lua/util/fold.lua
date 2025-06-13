-- fold
-- author ozoramore
--
-- foldexprを選択する. 優先度は以下の通り
-- 1. LSP
-- 2. treesitter

local setopt = function(exec)
	vim.api.nvim_set_option_value('foldmethod', 'expr', { scope = 'local' } )
	vim.api.nvim_set_option_value('foldexpr', exec, { scope = 'local' } )
end

local set_lsp = function(buf)
	local client = vim.lsp.get_clients({ buf })[1]
	local has_fold = client and client:supports_method('textDocument/completion')
	local expr = 'v:lua.vim.lsp.foldexpr()'

	if has_fold then setopt(expr) end
	return has_fold
end

local set_ts = function(buf)
	local has_parser = vim.treesitter.get_parser(buf, nil, { error = false })
	local expr = 'v:lua.vim.treesitter.foldexpr()'

	if has_parser then setopt(expr) end
	return has_parser
end

local FOLD = {}

FOLD.set = function(args)
	if set_lsp(args.buf) then return end
	if set_ts(args.buf) then return end
end

return FOLD
