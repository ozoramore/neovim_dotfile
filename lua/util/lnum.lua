local def_get_name = function(lnum, current_line)
	if lnum == current_line then return nil end
	local range = math.abs(lnum - current_line)
	if range <= 1 then return 'LineNrGroup1' end
	if range <= 2 then return 'LineNrGroup2' end
	if range <= 3 then return 'LineNrGroup3' end
	if range <= 4 then return 'LineNrGroup4' end
	return nil
end

local lnum_colors = {
	['LineNrGroup1'] = 'LineNrGroup1',
	['LineNrGroup2'] = 'LineNrGroup2',
	['LineNrGroup3'] = 'LineNrGroup3',
	['LineNrGroup4'] = 'LineNrGroup4',
	['LineNrInterval'] = 'LineNrInterval',
}

local def_hl = {
	['LineNrGroup1'] = { fg = 'yellow', bg = nil },
	['LineNrGroup2'] = { fg = 'orange', bg = nil },
	['LineNrGroup3'] = { fg = 'brown', bg = nil },
	['LineNrGroup4'] = { fg = 'darkred', bg = nil },
	['LineNrInterval'] = { fg = nil, bg = 'darkred' },
}

local set_def_hl = function(tbl)
	local hi = function(name, fg, bg, val)
		val = val or {}
		val.cterm = val.cterm or {}
		val.fg = fg
		val.bg = bg
		vim.api.nvim_set_hl(0, name, val)
	end

	for n, v in pairs(tbl) do
		if vim.fn.hlexists(n) == 0 then hi(n, v.fg, v.bg, nil) end
	end
end

local function color_def(tbl)
	for name, text in pairs(tbl) do
		vim.fn.sign_define(name, { numhl = text })
	end
end

local function set_static_sign(interval, lnum)
	if lnum % interval == 0 then
		vim.fn.sign_place(0, 'LineNrInterval', 'LineNrInterval', vim.fn.expand('%p'),
			{ lnum = lnum })
	end
end

local function set_dinamic_sign(get_name, lnum)
	local name = get_name(lnum, vim.api.nvim_win_get_cursor(0)[1])
	if name then vim.fn.sign_place(0, 'LineNrGroup', name, vim.fn.expand('%p'), { lnum = lnum }) end
end

local function per_line_exec(func)
	for i = 1, vim.api.nvim_buf_line_count(0) do func(i) end
end

local M = {}

M.setup = function(interval, get_name)
	get_name = get_name or def_get_name
	set_def_hl(def_hl)
	color_def(lnum_colors)
	if interval then
		local cb = function()
			per_line_exec(function(i) set_static_sign(interval, i) end)
		end
		vim.api.nvim_create_autocmd({ 'BufEnter' }, { callback = cb })
	end

	local lnumcb = function()
		vim.fn.sign_unplace('LineNrGroup')
		per_line_exec(function(i) set_dinamic_sign(get_name, i) end)
	end

	vim.api.nvim_create_autocmd(
		{ 'TextChanged', 'BufRead', 'BufNewFile', 'CursorMoved', 'CursorMovedI' },
		{ callback = lnumcb }
	)
end

return M
