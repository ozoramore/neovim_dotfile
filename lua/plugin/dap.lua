local gdb = {
	id = 'gdb',
	type = 'executable',
	name = 'C/C++ debugger',
	command = 'gdb',
	args = { '-i=dap', '-q' },
}

local get_launch_json = function()
	local buf = vim.api.nvim_buf_get_name(0)
	local root = require('util.rooter').root_dir(buf)
	if not root then return '' end
	return root .. '/.vscode/launch.json'
end

local setup_dap_view = function()
	require('dap-view').setup()
end

local get_debugger = function()
	local filetype = vim.bo.filetype
	local json = get_launch_json()
	local config = require('dap.ext.vscode').getconfigs(json)
	require('dap').configurations[filetype] = config
end

local M = {}
local load = require('plugin.mini').load

M.setup = function()
	local dap = require('dap')

	dap.adapters.gdb = gdb

	vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, { callback = get_debugger })

	-- keymaps
	vim.keymap.set({ 'n' }, '<F5>', dap.continue)
	vim.keymap.set({ 'n' }, '<F10>', dap.step_over)
	vim.keymap.set({ 'n' }, '<F11>', dap.step_into)
	vim.keymap.set({ 'n' }, '<F12>', dap.step_out)
	vim.keymap.set({ 'n' }, '<Leader>b', dap.toggle_breakpoint)
	vim.keymap.set({ 'n' }, '<Leader>B', dap.set_breakpoint)

	--tui
	load({ source = 'igorlfs/nvim-dap-view' }, setup_dap_view, true)
end

return M
