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
	local function default_indent() return set_indent(4, false) end
	setmetatable(indent_table, { __index = default_indent })[args.match]()
end

M.setup = function()
	vim.filetype.add({ extension = { h = 'cpp', def = 'cpp', tbl = 'cpp', inc = 'cpp', } })
	vim.api.nvim_create_autocmd('FileType', { callback = filetype_callback })
end

return M
