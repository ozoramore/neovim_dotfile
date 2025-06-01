local M = {}

M.statusline = function()
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

return M
