for k, v in pairs({
	-- Set up Global options.
	incsearch = true,
	backup = false,
	swapfile = false,
	encoding = 'utf-8',
	fileencoding = 'utf-8',
	fileencodings = 'utf-8,sjis,iso-2022-jp,euc-jp,default',
	fileformat = 'unix',
	fileformats = 'unix,dos,mac',
	langmenu = 'C.utf-8',
	helplang = 'ja,en',
	completeopt = 'menu,menuone,noselect,popup',
	undodir = '$XDG_DATA_HOME/nvim/undo',

	-- style options
	ambiwidth = 'single',
	number = true,
	showmatch = true,
	termguicolors = false,
	laststatus = 3,
	bg = 'dark',
	list = true,
	listchars = { tab = '>-', trail = '_', extends = '>', precedes = '<', nbsp = '%' },
}) do vim.opt[k] = v end

vim.cmd.language('en_US.UTF-8')

