require('option').setup()
require('fold').setup()
require('format').setup()
require('plugin').setup()

require('filetype').setup({
	['cpp'] = { 'h', 'def', 'tbl', 'inc' },
})

require('indent').setup({
	default = { tabstop = 4, is_expand = false },
	config = {
		markdown = { tabstop = 4, is_expand = true },
		yaml = { tabstop = 2, is_expand = true },
		json = { tabstop = 2, is_expand = true },
		ruby = { tabstop = 2, is_expand = true },
		rust = { tabstop = 4, is_expand = true },
		zig = { tabstop = 4, is_expand = true },
	},
})
