-- Linux Config.

local add, now = require('mini.deps').add, require('mini.deps').now

local function get_parent_path(name)
	local pwd = vim.api.nvim_buf_get_name(0)
	return ((vim.fn.finddir(name, ';', pwd) or pwd):match('(.+/)') or './')
end

local rootdir = get_parent_path('.git')

now(function()
	-- for ImputModule ( I use ATOK on Windows. )
	add({ source = 'h-hg/fcitx.nvim' })
end)

now(function()
	add({ source = 'neovim/nvim-lspconfig' })
	local lspconfig = require('lspconfig')
	lspconfig.clangd.setup({
		cmd = { 'clangd', '--header-insertion=never', '--clang-tidy', '--enable-config', '--compile-commands-dir=' .. rootdir, }
	})

	lspconfig.lua_ls.setup({
		settings = { Lua = { runtime = { version = 'LuaJIT', pathStrict = true, path = { '?.lua', '?/init.lua' } } } }
	})

	lspconfig.solargraph.setup({})

	lspconfig.bashls.setup({})

	vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = true }) end, {})
end)

now(function()
	add({ source = 'nvim-treesitter/nvim-treesitter' })
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'bash',
			'c',
			'cpp',
			'css',
			'html',
			'lua',
			'markdown',
			'markdown_inline',
			'python',
			'regex',
			'toml',
			'yaml',
			'vim',
			'vimdoc',
			'ruby',
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
	local setlogs = function()
		dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
	end
	local frames = function()
		widgets.centered_float(widgets.frames)
	end
	local scopes = function()
		widgets.centered_float(widgets.scopes)
	end

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
