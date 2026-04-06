local M = {}

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'

M.has = false

M.load = function(spec, setup, do_it_later)
	if not M.has then return end

	local _load = function()
		if spec then require('mini.deps').add(spec) end
		if setup then setup() end
	end
	local loader = require('mini.deps').now
	if do_it_later then loader = require('mini.deps').later end
	loader(_load)
end

M.initialize = function(url)
	if not url then os.exit() end

	print('Installing package manager. Please wait a moment..')
	vim.system({ 'git', 'clone', '--filter=blob:none', url, mini_path }, { text = true }):wait()
	vim.cmd.helptags('ALL')
	print('Done.')

	if (vim.version.ge(vim.version(), { 0, 12, 0 })) then
		vim.cmd.restart()
	else
		os.exit()
	end
end

M.setup = function(url)
	M.has = vim.uv.fs_stat(mini_path .. '/.git')
	if not M.has then M.initialize(url) end

	require('mini.deps').setup({ path = { package = path_package } })
end

return M
