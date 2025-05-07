-- Linux Config.

local add, now = require('mini.deps').add, require('mini.deps').now

now(function()
	add({ source = 'neovim/nvim-lspconfig' })
	local lspconfig = require('lspconfig')
	lspconfig.clangd.setup({ cmd = { 'clangd', '--header-insertion=never', '--clang-tidy', '--enable-config' } })
	lspconfig.lua_ls.setup({})
	lspconfig.solargraph.setup({})
	lspconfig.bashls.setup({})
	lspconfig.rust_analyzer.setup({ cmd = { "rustup", "run", "stable", "rust-analyzer" } })
	lspconfig.lemminx.setup({})
	lspconfig.ts_ls.setup {
	--	init_options = { plugins = { { name = '@vue/typescript-plugin', languages = { 'vue' } } } },
		filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
	}

	vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = true }) end, {})
end)

now(function()
	add({ source = 'nvim-treesitter/nvim-treesitter' })
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'c', 'cpp', 'rust',
			'bash', 'lua', 'python', 'ruby',
			'vue', 'typescript', 'javascript',
			'html', 'markdown', 'vimdoc',
			'css', 'xml', 'toml', 'yaml',
		},
		highlight = { enable = true },
		incremental_selection = { enable = true },
		indent = { enable = true },
		textobjects = { enable = true },
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
