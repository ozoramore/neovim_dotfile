local M = {}


M.treesitter = function()
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'c', 'cpp', 'rust', 'bash', 'lua', 'python',
			'ruby', 'vue', 'typescript', 'javascript', 'html', 'markdown',
			'vimdoc', 'css', 'xml', 'toml', 'yaml',
		},
		highlight = { enable = true },
		incremental_selection = { enable = true },
		indent = { enable = true },
		textobjects = { enable = true },
	})

	local function set_ts_fold(buf)
		local has_parser = vim.treesitter.get_parser(buf, nil, { error = false })
		if has_parser then vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' end
		return has_parser
	end

	local function set_folds(args)
		if require('lsp.fold').set(args.buf) then return end
		set_ts_fold(args.buf)
	end
	vim.api.nvim_create_autocmd('BufWinEnter', { callback = set_folds })
end

return M
