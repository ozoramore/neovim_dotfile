local options = {
	ambiwidth = 'single',
	number = true,
	showmatch = true,
	termguicolors = false,
	bg = 'dark',
	list = true,
	listchars = { tab = '>-', trail = '_', extends = '>', precedes = '<', nbsp = '%' },
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

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

now(function() -- status line
	add({ source = 'nvim-lualine/lualine.nvim' })
	local function style(fgcolor, bgcolor) return { fg = fgcolor, bg = bgcolor, gui = 'bold' } end
	require('lualine').setup({
		options = {
			globalstatus = true,
			theme = {
				normal = { a = style(nil, 'blue'), b = style(nil, 'gray'), c = style(nil, nil) },
				command = { a = style(nil, 'red') },
				insert = { a = style(nil, 'green') },
				visual = { a = style(nil, 'purple') },
				replace = { a = style(nil, 'orange') },
				inactive = { a = style('silver', 'gray'), b = style('gray', nil), c = style('silver', nil) },
			}
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'filename' },
			lualine_c = { 'searchcount' },
			lualine_x = { 'progress' },
			lualine_y = { { 'encoding', show_bomb = true }, 'fileformat', 'filetype' },
			lualine_z = { 'location' },
		},
	})
end)

now(function() -- status column
	add({ source = 'lewis6991/gitsigns.nvim' })
	local git_signs = {
		add = { text = '┃' },
		change = { text = '┃' },
		delete = { text = '⎣' },
		topdelete = { text = '⎡' },
		changedelete = { text = '╪' },
		untracked = { text = '┆' },
	}
	require('gitsigns').setup({ signs = git_signs, signs_staged = git_signs })
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
			{ sign = { namespace = { 'git.*' }, colwidth = 1, wrap = true, fillchar = '│', fillcharhl = 'NonText' }, click = 'v:lua.ScSa' },
		},
	})
end)
