local M = {}

local theme = { active = 'vim++', popup = 'vim++', bg = 'quiet++' }

local function choice_theme(win)
	if vim.api.nvim_win_get_config(win).relative ~= '' then
		return { colorscheme = theme.popup }
	elseif win == vim.api.nvim_get_current_win() then
		return { colorscheme = theme.active }
	else
		return { colorscheme = theme.bg }
	end
end

local function select_theme()
	for _, w in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		require('styler').set_theme(w, choice_theme(w))
	end
end

M.styler = function()
	vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, { callback = select_theme })
	vim.cmd.colorscheme(theme.active)
end

M.statusline = function()
	local function set_color(hl_name, fgcolor, bgcolor)
		local hl_color = { fg = fgcolor, bg = bgcolor, ctermbg = bgcolor, bold = true, force = true }
		vim.api.nvim_set_hl(0, hl_name, hl_color)
	end
	set_color('MiniStatuslineModeNormal', nil, 'DarkBlue')
	set_color('MiniStatuslineModeInsert', nil, 'DarkGreen')
	set_color('MiniStatuslineModeCommand', nil, 'DarkRed')
	set_color('MiniStatuslineModeVisual', nil, 'DarkMagenta')
	set_color('MiniStatuslineModeReplace', nil, 'DarkYellow')
	set_color('MiniStatuslineModeOther', nil, 'DarkGray')

	local mini_statusline = require('mini.statusline')
	local mode, mode_hl   = mini_statusline.section_mode({})
	local filename        = mini_statusline.section_filename({})
	local separator       = '%='
	local fileinfo        = mini_statusline.section_fileinfo({})
	local location        = '%4l:%3c'

	return mini_statusline.combine_groups({
		{ hl = mode_hl,      strings = { mode:upper() } },
		{ hl = 'StatusLine', strings = { filename, separator, fileinfo, location } },
	})
end

M.gitsigns = function()
	local git_signs = {
		add = { text = '┃' },
		change = { text = '┃' },
		delete = { text = '⎣' },
		topdelete = { text = '⎡' },
		changedelete = { text = '╪' },
		untracked = { text = '┆' },
	}
	require('gitsigns').setup({ signs = git_signs, signs_staged = git_signs })
end

M.statuscol = function()
	local builtin = require('statuscol.builtin')
	require('statuscol').setup({
		bt_ignore = { 'terminal', 'nofile' },
		relculright = true,
		segments = {
			{ text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
			{ sign = { namespace = { 'diagnostic' }, maxwidth = 1, colwidth = 1, auto = false }, click = 'v:lua.ScSa' },
			{ sign = { name = { 'Dap*' }, maxwidth = 1, colwidth = 1, auto = false }, click = 'v:lua.ScSa' },
			{ text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
			{ sign = { namespace = { 'git.*' }, colwidth = 1, wrap = true, fillchar = '│', fillcharhl = 'NonText' }, click = 'v:lua.ScSa' },
		},
	})
end

M.rainbow_csv = function()
	require('rainbow_csv').setup()
end

return M
