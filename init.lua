-- neovim設定
-- author ozoramore

--- 各種環境変数などなど
-- vim.v[key] = value
require('util.option').setvals({
	mapleader = ',',

	-- netrw(filemanager)
	netrw_banner = 0,
	netrw_liststyle = 1,
	netrw_sizestyle = 'H',
	netrw_winsize = 10,
	netrw_wiw = 1,
	netrw_browse_split = 3,
	netrw_timefmt = '%F %T%z',
	netrw_dirhistmax = 0,
	netrw_hide = 0,
})

-- vim.cmd[key](value)
require('util.option').setcmds({
	language = 'en_US.utf-8',
	colorscheme = 'omfg',
})

-- vim.opt[key] = value
require('util.option').setopts({
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
	foldmethod = 'indent',
	foldcolumn = '1',
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
	listchars = { tab = '>-', trail = '_', extends = '…', precedes = '…', nbsp = '␣' },

})

--- filetypeの紐付け
require('util.filetype').setup({
	['cpp'] = { 'h', 'def', 'tbl', 'inc' },
})

--- ファイルタイプごとのインデント設定
require('util.indent').setup({
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

-- FEP設定(OSごとに振り分け)
require('util.fep').setup()

--- フォーマッタ
vim.api.nvim_create_user_command('Format', require('util.format').exec, { nargs = 0 })

--- コードフォールディング
vim.api.nvim_create_autocmd('LspAttach', { callback = require('util.fold').set })

--- 外部プラグインのセットアップ
require('plugin').setup()
