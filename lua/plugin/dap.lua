local M = {}
local load = require('plugin.mini').load

M.setup = function()
	local dap = require('dap')
	dap.adapters.gdb = {
		id = 'gdb',
		type = 'executable',
		name = 'C/C++ debugger',
		command = 'gdb',
		args = { '-i=dap', '-q' },
	}
	local buf = vim.api.nvim_buf_get_name(0)
	local root = require('util.rooter').root_dir(buf)
	if not root then return end
	local filetype = vim.bo.filetype
	dap.configurations[filetype] = require('dap.ext.vscode').getconfigs(root .. '/.vscode/launch.json')

	vim.keymap.set({ 'n' }, '<F5>', dap.continue)
	vim.keymap.set({ 'n' }, '<F10>', dap.step_over)
	vim.keymap.set({ 'n' }, '<F11>', dap.step_into)
	vim.keymap.set({ 'n' }, '<F12>', dap.step_out)
	vim.keymap.set({ 'n' }, '<Leader>b', dap.toggle_breakpoint)
	vim.keymap.set({ 'n' }, '<Leader>B', dap.set_breakpoint)

	load({ source = 'rcarriga/nvim-dap-ui', }, function()
		load({ source = 'nvim-neotest/nvim-nio' }, nil)
		local dapui = require('dapui')
		dapui.setup()
		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close
	end, true)
end

return M
