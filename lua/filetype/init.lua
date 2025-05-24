local M = {}

local function set_indent(tab_length, is_expand)
	return function()
		vim.bo.expandtab = is_expand
		vim.bo.tabstop = tab_length
		vim.bo.shiftwidth = 0
		vim.bo.softtabstop = -1
	end
end

local indent_table = {
	yaml = set_indent(2, true),
	json = set_indent(2, true),
	ruby = set_indent(2, true),
	rust = set_indent(4, true),
	markdown = set_indent(4, true),
}

local function filetype_callback(args)
	local function default_indent()
		return set_indent(4, false)
	end
	setmetatable(indent_table, { __index = default_indent })[args.match]()

	--folding
	local function get_parser()
		local client = vim.lsp.get_client_by_id(1)
		if client and client:supports_method('textDocument/completion') then
			vim.opt.foldtext = 'v:lua.require(\'filetype.lsp_fold\').foldtext(v:foldstart, v:foldend, v:folddashes)'
			vim.opt.foldexpr = 'v:lua.require(\'filetype.lsp_fold\').foldexpr(v:lnum)'
		elseif require('nvim-treesitter.parsers').has_parser(args.match) then
			vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		else
			vim.opt.foldexpr = nil
		end
	end
	get_parser()
end

M.setup = function()
	vim.filetype.add({ extension = { h = 'cpp', def = 'cpp', tbl = 'cpp', inc = 'cpp', }, })
	vim.api.nvim_create_autocmd('FileType', { callback = filetype_callback })
end

return M
