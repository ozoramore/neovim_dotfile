local M = {}

local path_package = vim.fn.stdpath('data') .. '/site/'

M.load = function(spec, setup, do_it_later)
	local _load = function()
		if spec then require('mini.deps').add(spec) end
		if setup then setup() end
	end
	if do_it_later then
		require('mini.deps').later(_load)
	else
		require('mini.deps').now(_load)
	end
end

local packadd = function()
	local mini_path = path_package .. 'pack/deps/start/mini.nvim'
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
		require('mini.deps').setup({ path = { package = path_package } })
		require('mini.completion').setup()
		require('mini.tabline').setup()
		require('plugin.mini.snippets').setup()
		require('plugin.mini.statusline').setup()
	end
	M.load({ name = 'mini.nvim' }, setup, true)
end

return M
