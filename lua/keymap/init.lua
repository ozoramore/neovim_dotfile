vim.g.mapleader = ','

local function as_key_i(l, r)
	local function l_or_r() return vim.keycode(vim.fn.pumvisible() ~= 0 and r or l) end
	vim.keymap.set('i', l, l_or_r, { expr = true })
end

as_key_i('<Tab>', '<C-n>')
as_key_i('<S-Tab>', '<C-p>')
