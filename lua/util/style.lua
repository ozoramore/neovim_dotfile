local M = {}
M.ns = {
	active = 0,
	inactive = 0
}

local update = function(_)
	local curwin = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_hl_ns(curwin, M.ns.active)

	if string.len(vim.api.nvim_win_get_config(curwin).relative) ~= 0 then return end -- for floating window

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if win ~= curwin then vim.api.nvim_win_set_hl_ns(win, M.ns.inactive) end
	end
end

M.setup = function()
	M.ns.active = vim.api.nvim_get_namespaces()['active_window'] or 0
	M.ns.inactive = vim.api.nvim_get_namespaces()['inactive_window'] or 0
	vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, { callback = update })
end

return M
