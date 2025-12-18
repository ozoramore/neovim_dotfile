local gdb = {
	id = 'gdb',
	type = 'executable',
	name = 'C/C++ debugger',
	command = 'gdb',
	args = { '-i=dap', '-q' },
}

local get_launch_json = function(path)
	local root = require('util.file').root_dir(path) or '.'
	return root .. '/.vscode/launch.json'
end

local get_debugger = function(bufnr)
	local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
	local path = vim.api.nvim_buf_get_name(bufnr)
	if filetype == '' or path == '' then return {} end
	local json = get_launch_json(path)
	if not require('util.file').is_exist(json) then return {} end
	return require('dap.ext.vscode').getconfigs(json)
end

local M = {}

M.setup = function()
	local dap = require('dap')

	dap.adapters.gdb = gdb
	dap.providers.configs['dap.launch.json'] = get_debugger

	-- keymaps
	vim.keymap.set({ 'n' }, '<F5>', dap.continue)
	vim.keymap.set({ 'n' }, '<F10>', dap.step_over)
	vim.keymap.set({ 'n' }, '<F11>', dap.step_into)
	vim.keymap.set({ 'n' }, '<F12>', dap.step_out)
	vim.keymap.set({ 'n' }, '<Leader>b', dap.toggle_breakpoint)
	vim.keymap.set({ 'n' }, '<Leader>B', dap.set_breakpoint)

	--tui
	require('dap-view').setup()
end

return M
