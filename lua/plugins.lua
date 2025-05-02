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

	local function as_key_i(l, r)
		vim.keymap.set('i', l, function() return vim.keycode(vim.fn.pumvisible() ~= 0 and r or l) end, { expr = true })
	end
	as_key_i('<Tab>', '<C-n>')
	as_key_i('<S-Tab>', '<C-p>')
end)

if vim.fn.has('unix') == 1 then
	if vim.fn.has("wsl") == 1 then
		require('plugin/wsl')
	else
		now(function() add({ source = 'h-hg/fcitx.nvim' }) end)
	end
	require('plugin/for_linux')
end

require('plugin/styles')
