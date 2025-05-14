-- Linux Config.

local add, now = require('mini.deps').add, require('mini.deps').now

now(function()
	add({ source = 'neovim/nvim-lspconfig' })
	local lspconfig = require('lspconfig')
	lspconfig.lua_ls.setup({})
	lspconfig.solargraph.setup({})
	lspconfig.bashls.setup({})
	lspconfig.lemminx.setup({})
	lspconfig.clangd.setup({ cmd = { 'clangd', '--header-insertion=never', '--clang-tidy', '--enable-config' } })
	lspconfig.rust_analyzer.setup({ cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' } })
	lspconfig.ts_ls.setup({ filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' } })

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('my.lsp', {}),
		callback = function(args)
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
			if client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end
		end,
	})
end)

now(function()
	add({ source = 'mfussenegger/nvim-dap' })
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

	vim.keymap.set('n', '<F5>', dap.continue)
	vim.keymap.set('n', '<F10>', dap.step_over)
	vim.keymap.set('n', '<F11>', dap.step_into)
	vim.keymap.set('n', '<F12>', dap.step_out)
	vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
	vim.keymap.set('n', '<Leader>B', dap.set_breakpoint)
	vim.keymap.set('n', '<Leader>lp', setlogs)
	vim.keymap.set('n', '<Leader>dr', dap.repl.open)
	vim.keymap.set('n', '<Leader>dl', dap.run_last)
	vim.keymap.set({ 'n', 'v' }, '<Leader>dh', widgets.hover)
	vim.keymap.set({ 'n', 'v' }, '<Leader>dp', widgets.preview)
	vim.keymap.set('n', '<Leader>df', frames)
	vim.keymap.set('n', '<Leader>ds', scopes)
end)
