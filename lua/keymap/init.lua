local M = {}

M.as_key_i = function(l, r)
	local function l_or_r()
		if vim.fn.pumvisible() ~= 0 then return r end
		return l
	end
	vim.keymap.set('i', l, l_or_r, { expr = true })
end

M.setup = function()
	vim.g.mapleader = ','
	M.as_key_i('<Tab>', '<C-n>')
	M.as_key_i('<S-Tab>', '<C-p>')
end

return M
