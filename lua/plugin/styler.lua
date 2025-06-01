local M = {}

local theme = { active = 'omfg', popup = 'omfg', bg = 'ombg' }

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

function M.setup()
	vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, { callback = select_theme })
	vim.cmd.colorscheme(theme.active)
end

return M
