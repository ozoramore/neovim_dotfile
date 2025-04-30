local options = {
	ambiwidth = 'single',
	number = true,
	showmatch = true,
	termguicolors = false,
	laststatus = 3,
	bg = 'dark',
	list = true,
	listchars = { tab = '>-', trail = '_', extends = '>', precedes = '<', nbsp = '%' },
}

for k, v in pairs(options) do vim.opt[k] = v end

local add, now = require('mini.deps').add, require('mini.deps').now

now(function() -- colorscheme
	add({ source = 'folke/styler.nvim' })
	local theme = { active = 'vim++', popup = 'vim++', bg = 'quiet++' }

	local function select_theme()
		for _, w in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			local t = theme.bg
			if w == vim.api.nvim_get_current_win() then t = theme.active end
			if vim.api.nvim_win_get_config(w).relative ~= '' then t = theme.popup end
			require('styler').set_theme(w, { colorscheme = t })
		end
	end
	vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, { callback = select_theme })
	vim.cmd.colorscheme(theme.active)
end)

now(function()
	add({ source = 'cameron-wags/rainbow_csv.nvim' })
	require('rainbow_csv').setup()
end)

local function statusline()
	local function style(hl_name, fgcolor, bgcolor)
		vim.api.nvim_set_hl(0, hl_name, { fg = fgcolor, bg = bgcolor, ctermbg = bgcolor, bold = true, force = true })
	end

	style('MiniStatuslineModeNormal', nil, "DarkBlue")
	style('MiniStatuslineModeInsert', nil, "DarkGreen")
	style('MiniStatuslineModeCommand', nil, "DarkRed")
	style('MiniStatuslineModeVisual', nil, "DarkMagenta")
	style('MiniStatuslineModeReplace', nil, "DarkYellow")
	style('MiniStatuslineModeOther', nil, "DarkGray")

	local msl           = require('mini.statusline')
	local mode, mode_hl = msl.section_mode({})
	local filename      = msl.section_filename({})
	local separator     = "%="
	local fileinfo      = msl.section_fileinfo({})
	local location      = "%l:%c"

	return msl.combine_groups({
		{ hl = mode_hl,      strings = { mode:upper() } },
		{ hl = 'StatusLine', strings = { filename, separator, fileinfo, location } },
	})
end

require('mini.statusline').setup({ content = { active = statusline, inactive = statusline } })
require('mini.tabline').setup()

now(function() -- status column
	local git_signs = { add = '┃', change = '│', delete = '┊', }
	require('mini.diff').setup({ view = { style = 'sign', signs = git_signs } })
	add({ source = 'luukvbaal/statuscol.nvim' })
	local builtin = require('statuscol.builtin')
	require('statuscol').setup({
		bt_ignore = { 'terminal', 'nofile' },
		relculright = true,
		segments = {
			{ text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
			{ sign = { namespace = { 'diagnostic' }, maxwidth = 1, colwidth = 1, auto = false }, click = 'v:lua.ScSa' },
			{ sign = { name = { 'Dap*' }, maxwidth = 1, colwidth = 1, auto = false }, click = 'v:lua.ScSa' },
			{ text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
			{ sign = { namespace = { 'MiniDiff*' }, colwidth = 1, wrap = true, fillchar = '│', fillcharhl = 'NonText' }, click = 'v:lua.ScSa' },
		},
	})
end)
