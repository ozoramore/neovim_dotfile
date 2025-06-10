local M = {}

local function sign_def(tbl)
	for name, text in pairs(tbl) do
		vim.fn.sign_define(name, { text = text })
	end
end

M.setup = function()
	local dap = require('dap')
	dap.adapters.gdb = {
		id = 'gdb',
		type = 'executable',
		name = 'C/C++ debugger',
		command = 'gdb',
		args = { '-i=dap', '-q' },
	}

	local dap_signs = {
		['DapBreakpoint'] = '●',
		['DapBreakpointCondition'] = '◑',
		['DapBreakpointRejected'] = '◌',
		['DapLogPoint'] = '◩',
		['DapStopped'] = '▶',
	}

	sign_def(dap_signs)

	local widgets = require('dap.ui.widgets')
	local function setlogs() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end
	local function frames() widgets.centered_float(widgets.frames) end
	local function scopes() widgets.centered_float(widgets.scopes) end

	vim.keymap.set({ 'n' }, '<F5>', dap.continue)
	vim.keymap.set({ 'n' }, '<F10>', dap.step_over)
	vim.keymap.set({ 'n' }, '<F11>', dap.step_into)
	vim.keymap.set({ 'n' }, '<F12>', dap.step_out)
	vim.keymap.set({ 'n' }, '<Leader>b', dap.toggle_breakpoint)
	vim.keymap.set({ 'n' }, '<Leader>B', dap.set_breakpoint)
	vim.keymap.set({ 'n' }, '<Leader>lp', setlogs)
	vim.keymap.set({ 'n' }, '<Leader>dr', dap.repl.open)
	vim.keymap.set({ 'n' }, '<Leader>dl', dap.run_last)
	vim.keymap.set({ 'n', 'v' }, '<Leader>dh', widgets.hover)
	vim.keymap.set({ 'n', 'v' }, '<Leader>dp', widgets.preview)
	vim.keymap.set({ 'n' }, '<Leader>df', frames)
	vim.keymap.set({ 'n' }, '<Leader>ds', scopes)
end

return M
