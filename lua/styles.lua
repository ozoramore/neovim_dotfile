local options = {
	ambiwidth = 'single',
	number = true,
	showmatch = true,
	termguicolors = false,
	bg = 'dark',
	list = true,
	listchars = { tab = '>-', trail = '_' ,extends = '>', precedes = '<', nbsp = '%', },
}

vim.cmd.colorscheme('vim++')
for k, v in pairs(options) do
	vim.opt[k] = v
end

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({ source = 'nvim-lualine/lualine.nvim' })
add({ source = 'folke/styler.nvim' })

now(function()
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
end)

now(function()
	require('lualine').setup{
		options = { icons_enabled = true, globalstatus = true, theme = require('theme.lualine.hm'), },
		sections = {
			lualine_a = { 'mode', },
			lualine_b = { 'filename', },
			lualine_c = { 'searchcount', },
			lualine_x = { 'progress', },
			lualine_y = { { 'encoding', show_bomb = true }, 'fileformat', 'filetype', },
			lualine_z = { 'location', },
		}
	}
end)

vim.api.nvim_create_autocmd( { 'WinEnter', 'BufEnter' }, {
	callback = function()
		local set_theme = require('styler').set_theme
		local win = vim.api.nvim_get_current_win()
		for _, w in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(w).relative ~= "" then
				set_theme(w, { colorscheme = 'vim++' }) -- popup window
			elseif w == win then
				set_theme(w, { colorscheme = 'vim++' }) -- active window
			else
				set_theme(w, { colorscheme = 'quiet++' }) -- inactive window
			end
		end
	end
})
