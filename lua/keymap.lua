-- keymap.lua
-- author ozoramore
--
-- 現在の設定
-- 1. Tabキー補完
-- 2. Leaderキーを `,` に設定
-- 3. (plugin.gdb) gdb有効時の設定

local M = {}

local function as_key(mode, l, r)
	local function l_or_r()
		if vim.fn.pumvisible() ~= 0 then return r end
		return l
	end
	vim.keymap.set(mode, l, l_or_r, { expr = true })
end

M.as_key = as_key

M.setup = function()
	-- Tabキーで候補を選択する
	as_key('i', '<Tab>', '<C-n>')
	as_key('i', '<S-Tab>', '<C-p>')
	-- leaderキーの設定
	vim.g.mapleader = ','
end

return M
