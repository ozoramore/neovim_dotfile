-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
-- Credit itchyny, jackno (lightline), mori-oh
-- stylua: ignore

return {
	normal = {
		a = { fg = nil, bg = 'blue', gui = 'bold' },
		b = { fg = nil, bg = 'gray', gui = 'bold' },
		c = { fg = nil, bg = nil, gui = 'bold' },
	},
	insert = { a = { fg = nil, bg = 'green', gui = 'bold' } },
	visual = { a = { fg = nil, bg = 'purple', gui = 'bold' } },
	replace = { a = { fg = nil, bg = 'red', gui = 'bold' } },
	inactive = {
		a = { fg = 'silver', bg = 'gray', gui = 'bold' },
		b = { fg = 'gray', bg = nil, gui = 'bold' },
		c = { fg = 'silver', bg = nil, gui = 'bold' },
	},
}
