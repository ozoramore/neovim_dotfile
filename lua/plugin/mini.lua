local M = {}

M.deps = {
	add = require('mini.deps').add,
	now = require('mini.deps').now,
	path_package = vim.fn.stdpath('data') .. '/site/'
}

local function statusline()
	local mode, mode_hl = require('mini.statusline').section_mode({})
	local filename      = require('mini.statusline').section_filename({})
	local separator     = '%='
	local fileinfo      = require('mini.statusline').section_fileinfo({})
	local location      = '%4l:%3c'

	return require('mini.statusline').combine_groups({
		{ hl = mode_hl,      strings = { mode:upper() } },
		{ hl = 'StatusLine', strings = { filename, separator, fileinfo, location } },
	})
end

M.statusline = {
	contents = {
		content = {
			active = statusline,
			inactive = statusline,
		}
	}
}

local function snippets_stop()
	local s = require('mini.snippets').session
	local function all_stop() while s.get() do s.stop() end end
	vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*:n', once = true, callback = all_stop })
end

M.packadd = function()
	local mini_path = M.deps.path_package .. 'pack/deps/start/mini.nvim'
	local mini_repo = 'https://github.com/echasnovski/mini.nvim'
	if not vim.loop.fs_stat(mini_path) then
		vim.system({ 'git', 'clone', '--filter=blob:none', mini_repo, mini_path, })
		vim.cmd.packadd('mini.nvim')
	end
end

M.setup = function()
	local setup = function()
		M.deps.add({ name = 'mini.nvim' })
		require('mini.deps').setup({ path = { package = M.deps.path_package } })
		require('mini.completion').setup()
		require('mini.snippets').setup()
		require('mini.tabline').setup()
		require('mini.statusline').setup(M.statusline.contents)
		vim.api.nvim_create_autocmd('User', { pattern = 'MiniSnippetsSessionStart', callback = snippets_stop })
	end
	M.deps.now(setup)
end

return M
