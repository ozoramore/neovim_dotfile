local STATUSLINE = {}

local statusline = require('mini.statusline')

local function line()
	local mode, mode_hl = statusline.section_mode({})
	local filename      = statusline.section_filename({})
	local separator     = '%='
	local fileinfo      = statusline.section_fileinfo({})
	local location      = '%4l:%3c'

	return statusline.combine_groups({
		{ hl = mode_hl,      strings = { mode:upper() } },
		{ hl = 'StatusLine', strings = { filename, separator, fileinfo, location } },
	})
end

STATUSLINE.setup = function()
	require('mini.statusline').setup({
		content = { active = line, inactive = line }
	})
end

return STATUSLINE
