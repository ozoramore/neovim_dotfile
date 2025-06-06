require('option').setvals({
	mapleader = ',',
})

require('option').setcmds({
	language = 'en_US.utf-8',
	colorscheme = 'omfg',
})

require('option').setopts({
	incsearch = true,
	backup = false,
	swapfile = false,
	completeopt = { 'menu', 'menuone', 'noselect', 'popup' },
	undodir = '$XDG_DATA_HOME/nvim/undo',

	-- encoding,fileformat,language
	encoding = 'utf-8',
	fileencoding = 'utf-8',
	fileencodings = { 'utf-8', 'sjis', 'iso-2022-jp', 'euc-jp', 'default' },
	fileformat = 'unix',
	fileformats = { 'unix', 'dos', 'mac' },
	langmenu = 'C.utf-8',
	helplang = { 'ja', 'en' },

	-- fold
	foldenable = true,
	foldmethod = 'expr',
	foldcolumn = '2',
	foldlevel = 99,

	-- style
	cursorline = true,
	ambiwidth = 'single',
	number = true,
	showmatch = true,
	termguicolors = true,
	laststatus = 3,
	bg = 'dark',
	list = true,
	fillchars = { fold = ' ', foldopen = '┌', foldsep = '│', foldclose = '─' },
	listchars = { tab = '>-', trail = '_', extends = '>', precedes = '<', nbsp = '%' },
})

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
