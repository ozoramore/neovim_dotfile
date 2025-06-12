-- neovim設定
-- author ozoramore

--- 各種環境変数などなど
-- vim.v[key] = value
require('util.option').setvals({
	mapleader = ',',
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

--- フォーマッタ
vim.api.nvim_create_user_command('Format', require('util.format').exec, { nargs = 0 })

--- コードフォールディング
vim.api.nvim_create_autocmd('BufCreate', { callback = require('util.fold').set })

--- 各種プラグイン設定
require('plugin.mini').setup() -- `load` は mini.deps 依存のため 先にplugin.miniをsetupしておく.
local load = require('plugin.mini').load

-- neovimでmpdを制御する自作プラグイン
load('ozoramore/nvimpc.lua', require('plugin.mpc').setup)

-- 外観
load('folke/styler.nvim', require('plugin.styler').setup)
load('lewis6991/gitsigns.nvim', require('plugin.gitsigns').setup)
load('luukvbaal/statuscol.nvim', require('plugin.statuscol').setup)

-- DAP/treesitter/lspなど、外部コマンドに依存する系の設定
if vim.fn.has('unix') == 1 then
	load('mfussenegger/nvim-dap', require('plugin.dap').setup)
	load('nvim-treesitter/nvim-treesitter', require('plugin.treesitter').setup)
	load('neovim/nvim-lspconfig', require('plugin.lsp').setup)
end

-- FEP設定(OSごとに振り分け)
require('plugin.fep').setup()
