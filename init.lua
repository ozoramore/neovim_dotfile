-- Set up Global options.
require('options')

vim.filetype.add({
	extension = {
		h = 'cpp',
		def = 'cpp',
		tbl = 'cpp',
		inc = 'cpp',
	},
})

-- Set up each filetype options.
local function filetype_process(filetype)
	require('filetypes')[filetype.match]()
end

vim.api.nvim_create_autocmd('FileType', { callback = filetype_process })

-- Set up external plugin.
require('plugins')
