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

	local mode, mode_hl = require('mini.statusline').section_mode({})
	local filename      = require('mini.statusline').section_filename({})
	local separator     = '%='
	local fileinfo      = require('mini.statusline').section_fileinfo({})
	local location      = '%4l:%3c'

	return require('mini.statusline').combine_groups({
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
	local function signs(ns, add_sign)
		local sign = { namespace = { ns }, maxwidth = 1, colwidth = 1, auto = false }
		for k, v in pairs(add_sign) do sign[k] = v end
		return { sign = sign, click = 'v:lua.ScSa' }
	end
	require('statuscol').setup({
		bt_ignore = { 'terminal', 'nofile' },
		relculright = true,
		segments = {
			signs('diagnostic', {}),
			signs('Dap*', {}),
			{ text = { require('statuscol.builtin').lnumfunc }, click = 'v:lua.ScLa' },
			{ text = { require('statuscol.builtin').foldfunc }, click = 'v:lua.ScFa' },
			signs('git.*', { wrap = true, fillchar = '│', fillcharhl = 'NonText' }),
		}
	})
end

M.rainbow_csv = function()
	require('rainbow_csv').setup()
end

return M
