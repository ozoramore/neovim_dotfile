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
vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function(args)
		require('filetypes')[args.match]()
	end,
})

-- Set up external plugin.
require('plugins')
