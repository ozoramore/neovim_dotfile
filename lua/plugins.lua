-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
local mini_repo = 'https://github.com/echasnovski/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	vim.system({ 'git', 'clone', '--filter=blob:none', mini_repo, mini_path, })
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add, now = require('mini.deps').add, require('mini.deps').now

now(function()
	add({ name = 'mini.nvim' })
	require('mini.completion').setup()
	require('mini.snippets').setup()

	local function make_stop()
		local mini_snippets = require('mini.snippets')
		local function all_stop() while mini_snippets.session.get() do mini_snippets.session.stop() end end
		vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*:n', once = true, callback = all_stop })
	end
	vim.api.nvim_create_autocmd('User', { pattern = 'MiniSnippetsSessionStart', callback = make_stop })

	local function as_key_i(l, r)
		vim.keymap.set('i', l, function() return vim.keycode(vim.fn.pumvisible() ~= 0 and r or l) end, { expr = true })
	end
	as_key_i('<Tab>', '<C-n>')
	as_key_i('<S-Tab>', '<C-p>')
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

local function lsp_formatter() vim.lsp.buf.format({ async = true }) end
local function native_formatter()
	local pos = vim.fn.getpos('.')
	vim.cmd.normal('gg=G')
	vim.fn.setpos('.', pos)
end
local function select_formatter()
	local lsp_client = vim.lsp.get_clients({ bufnr = 0 })[1]
	local selector = lsp_client and lsp_client:supports_method('textDocument/formatting')
	if selector then lsp_formatter() else native_formatter() end
end
vim.api.nvim_create_user_command('Format', select_formatter, {})


if vim.fn.has('unix') == 1 then
	if vim.fn.has("wsl") == 1 then
		require('plugin.wsl')
	else
		now(function() add({ source = 'h-hg/fcitx.nvim' }) end)
	end
	require('plugin.for_linux')
end

require('plugin.styles')
