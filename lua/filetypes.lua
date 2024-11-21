local M = {}

local function set_indent( tab_length, is_expand )
	vim.bo.expandtab = is_expand
	vim.bo.tabstop = tab_length
	vim.bo.shiftwidth = 0
	vim.bo.softtabstop = -1
end

M.yaml = function()
	set_indent(2,true)
end

M.ruby = function()
	set_indent(2,true)
end

return setmetatable(M, {
	__index = function()
		return function()
			set_indent( 4, false )
		end
	end
})
