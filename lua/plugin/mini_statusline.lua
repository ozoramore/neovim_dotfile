local STATUSLINE = {}

STATUSLINE.setup = function()
	local statusline = require('mini.statusline')

	local function hl(mode)
		if mode == 'Normal' then return 'OMStatuslineModeNormal' end
		if mode == 'Insert' then return 'OMStatuslineModeInsert' end
		if mode == 'Command' then return 'OMStatuslineModeCommand' end
		if mode == 'Visual' then return 'OMStatuslineModeVisual' end
		if mode == 'Replace' then return 'OMStatuslineModeReplace' end
		return 'OMStatuslineModeOther'
	end
	local function line()
		local mode, mode_hl = statusline.section_mode({})
		local truncate      = '%<'
		local filename      = statusline.section_filename({ trunc_width = 150 })
		local separator     = '%='
		local fileinfo      = statusline.section_fileinfo({})
		local location      = '%4l:%3c'

		return statusline.combine_groups({
			{ hl = mode_hl,  strings = { mode:upper() } },
			truncate,
			{ hl = hl(mode), strings = { filename, separator, fileinfo, location } },
		})
	end

	statusline.setup({ content = { active = line, inactive = line } })
end

return STATUSLINE
