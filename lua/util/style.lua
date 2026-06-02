local M = {}
M.ns = {
	active = 0,
	inactive = 0
}

local update = function(_)
	local curwin = vim.api.nvim_get_current_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local ns = M.ns.inactive
		if (win == curwin) then ns = M.ns.active end
		vim.api.nvim_win_set_hl_ns(win, ns)
	end
end

M.setup = function()
	M.ns.active = vim.api.nvim_get_namespaces()["active_window"] or 0
	M.ns.inactive = vim.api.nvim_get_namespaces()["inactive_window"] or 0
	vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'ModeChanged' }, { callback = update })
end

return M
