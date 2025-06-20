local def_get_name = function(lnum, current_line)
	if lnum == current_line then return nil end
	if lnum % 10 == 0 then return 'LineNumberGroup5' end
	local range = math.abs(lnum - current_line)
	if range <= 1 then return 'LineNumberGroup1' end
	if range <= 2 then return 'LineNumberGroup2' end
	if range <= 3 then return 'LineNumberGroup3' end
	if range <= 4 then return 'LineNumberGroup4' end
	return nil
end

local lnum_colors = {
	['LineNumberGroup1'] = 'LineNumberGroup1',
	['LineNumberGroup2'] = 'LineNumberGroup2',
	['LineNumberGroup3'] = 'LineNumberGroup3',
	['LineNumberGroup4'] = 'LineNumberGroup4',
	['LineNumberGroup5'] = 'LineNumberGroup5',
}

-- ダサいのでできれば各自設定してね
local def_hl = {
	['LineNumberGroup1'] = { fg = 'yellow', bg = 'NONE' },
	['LineNumberGroup2'] = { fg = 'red', bg = 'NONE' },
	['LineNumberGroup3'] = { fg = 'green', bg = 'NONE' },
	['LineNumberGroup4'] = { fg = 'blue', bg = 'NONE' },
	['LineNumberGroup5'] = { fg = 'magenta', bg = 'NONE' },
}

local set_def_hl = function(tbl)
	local hi = function(name, fg, bg, val)
		val = val or {}
		val.cterm = val.cterm or {}
		val.fg = fg
		val.bg = bg
		vim.api.nvim_set_hl(0, name, val)
	end

	for name, val in pairs(tbl) do
		if not vim.fn.hlexists(name) then hi(name, val.fg, val.bg) end
	end
end

local function color_def(tbl)
	for name, text in pairs(tbl) do
		vim.fn.sign_define(name, { numhl = text })
	end
end

local function set_sign(get_name, lnum)
	local name = get_name(lnum, vim.api.nvim_win_get_cursor(0)[1])
	if name then vim.fn.sign_place(0, 'LineNumberGroup', name, vim.fn.expand('%p'), { lnum = lnum }) end
end

local M = {}

M.setup = function(get_name)
	set_def_hl(def_hl)
	color_def(lnum_colors)
	local lnumcb = function()
		vim.fn.sign_unplace('LineNumberGroup')
		for i = 1, vim.api.nvim_buf_line_count(0) do set_sign(get_name or def_get_name, i) end
	end
	vim.api.nvim_create_autocmd(
		{ 'TextChanged', 'TextChangedT', 'BufRead', 'BufNewFile', 'CursorMoved', 'CursorMovedI' },
		{ callback = lnumcb }
	)
end

return M
