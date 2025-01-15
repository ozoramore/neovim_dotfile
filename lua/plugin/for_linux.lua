-- Linux Config.

local add, now = MiniDeps.add, MiniDeps.now

-- for ImputModule ( I use ATOK on Windows. )
add({ source = 'h-hg/fcitx.nvim' })

local function get_parent_path(name)
	local pwd = vim.api.nvim_buf_get_name(0)
	return ((vim.fn.finddir(name, ';', pwd) or pwd):match('(.+/)') or '../')
end

add({ source = 'ckipp01/stylua-nvim' })
now(function()
	require('stylua-nvim').setup()
end)

add({ source = 'rhysd/vim-clang-format' })
add({ source = 'neovim/nvim-lspconfig' })
now(function()
	local lspconfig = require('lspconfig')
	lspconfig.clangd.setup({
		cmd = {
			'clangd',
			'--header-insertion=never',
			'--clang-tidy',
			'--enable-config',
			'--compile-commands-dir=' .. get_parent_path('.git'),
		},
		commands = { Format = {
			function()
				vim.cmd('ClangFormat')
			end,
		} },
	})
	lspconfig.lua_ls.setup({
		settings = {
			Lua = { runtime = { version = 'LuaJIT', pathStrict = true, path = { '?.lua', '?/init.lua' } } },
		},
		commands = { Format = {
			function()
				require('stylua-nvim').format_file()
			end,
		} },
	})
	lspconfig.solargraph.setup({})
	require('mini.completion').setup()
	local imap_expr = function(lhs, rhs)
		vim.keymap.set('i', lhs, rhs, { expr = true })
	end
	imap_expr('<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
	imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
end)

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

add({ source = 'rcarriga/nvim-dap-ui', depends = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } })
now(function()
	require('dap').adapters.gdb = {
		id = 'gdb',
		type = 'executable',
		command = 'gdb',
		args = { '--quiet', '--interpreter=dap' },
	}
	require('dap.ext.vscode').load_launchjs((get_parent_path('.git') .. '.vscode/launch.json'), { gdb = { 'c', 'cpp' } })
	require('dapui').setup({
		icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { '<CR>', '<2-LeftMouse>' },
			open = 'o',
			remove = 'd',
			edit = 'e',
			repl = 'r',
			toggle = 't',
		},
	})
	local function map(mode, lhs, rhs, opts)
		local options = { noremap = true }
		if opts then
			options = vim.tbl_extend('force', options, opts)
		end
		vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	end
	map('n', '<F5>', ":lua require'dap'.continue()<CR>", { silent = true })
	map('n', '<F10>', ":lua require'dap'.step_over()<CR>", { silent = true })
	map('n', '<F11>', ":lua require'dap'.step_into()<CR>", { silent = true })
	map('n', '<F12>', ":lua require'dap'.step_out()<CR>", { silent = true })
	map('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
	map('n', '<leader>bc', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true })
	map('n', '<leader>l', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { silent = true })
	-- dap-ui key map
	map('n', '<leader>d', ":lua require'dapui'.toggle()<CR>", { silent = true })
	map('n', '<leader><leader>df', ":lua require'dapui'.eval()<CR>", { silent = true })
	-- dap-go key map
	map('n', '<leader>td', ":lua require'dap-go'.debug_test()<CR>", { silent = true })
end)
