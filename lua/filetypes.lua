local function set_indent(tab_length, is_expand)
	return function()
		vim.bo.expandtab = is_expand
		vim.bo.tabstop = tab_length
		vim.bo.shiftwidth = 0
		vim.bo.softtabstop = -1
	end
end

local function default()
	return set_indent(4, false)
end

local M = {
	yaml = set_indent(2, true),
	ruby = set_indent(2, true),
	rust = set_indent(4, true),
	markdown = set_indent(4, true)
}

return setmetatable(M, { __index = default })
