-- Linux Config.
local M = {}

M.lspconfig = function()
	local clangd = { 'clangd', '--header-insertion=never', '--clang-tidy', '--enable-config' }
	local rust_analyzer = { 'rustup', 'run', 'stable', 'rust-analyzer' }

	require('lspconfig').lua_ls.setup({})
	require('lspconfig').solargraph.setup({})
	require('lspconfig').bashls.setup({})
	require('lspconfig').lemminx.setup({})
	require('lspconfig').clangd.setup({ cmd = clangd })
	require('lspconfig').rust_analyzer.setup({ cmd = rust_analyzer })
	require('lspconfig').ts_ls.setup({})

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('my.lsp', {}),
		callback = function(args)
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
			if client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end
		end,
	})
end

M.nvim_dap = function()
	local dap = require('dap')
	dap.adapters.gdb = {
		id = 'gdb',
		type = 'executable',
		name = 'C/C++ debugger',
		command = 'gdb',
		args = { '-i=dap', '-q' },
	}

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

M.treesitter = function()
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'c', 'cpp', 'rust', 'bash', 'lua', 'python',
			'ruby', 'vue', 'typescript', 'javascript', 'html', 'markdown',
			'vimdoc', 'css', 'xml', 'toml', 'yaml',
		},
		highlight = { enable = true },
		incremental_selection = { enable = true },
		indent = { enable = true },
		textobjects = { enable = true },
	})
end

return M
