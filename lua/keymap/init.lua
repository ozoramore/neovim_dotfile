local M = {}

local if_a_else_b = require('util').if_a_else_b

M.as_key_i = function(l, r)
	local function l_or_r()
		return if_a_else_b(vim.fn.pumvisible() ~= 0, r, l)
	end
	vim.keymap.set('i', l, l_or_r, { expr = true })
end

M.setup = function()
	vim.g.mapleader = ','
	M.as_key_i('<Tab>', '<C-n>')
	M.as_key_i('<S-Tab>', '<C-p>')
end

return M
