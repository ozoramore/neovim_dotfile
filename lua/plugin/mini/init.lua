local M = {}

M.deps = {
	add = require('mini.deps').add,
	now = require('mini.deps').now,
	path_package = vim.fn.stdpath('data') .. '/site/'
}

M.deps.load = function(src, setup)
	local _load = function()
		if src then require('plugin.mini').deps.add({ source = src }) end
		if setup then setup() end
	end
	require('plugin.mini').deps.now(_load)
end

local packadd = function()
	local mini_path = M.deps.path_package .. 'pack/deps/start/mini.nvim'
	local mini_repo = 'https://github.com/echasnovski/mini.nvim'
	if not vim.uv.fs_stat(mini_path) then
		vim.system({ 'git', 'clone', '--filter=blob:none', mini_repo, mini_path })
		vim.cmd.helptags('ALL')
		print("Please restart neovim.")
		-- TODO: Put vim.cmd.restart()
		-- ( vim.cmd.restart is depends on NVIM v0.12 or later. )
	end
end

M.setup = function()
	packadd()
	local setup = function()
		M.deps.add({ name = 'mini.nvim' })
		require('mini.deps').setup({ path = { package = M.deps.path_package } })
		require('mini.completion').setup()
		require('mini.tabline').setup()
		require('plugin.mini.snippets').setup()
		require('plugin.mini.statusline').setup()
	end
	M.deps.now(setup)
end

return M
