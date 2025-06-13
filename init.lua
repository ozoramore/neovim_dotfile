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
	foldmethod = 'indent',
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

-- FEP設定(OSごとに振り分け)
require('util.fep').setup()

--- フォーマッタ
vim.api.nvim_create_user_command('Format', require('util.format').exec, { nargs = 0 })

--- コードフォールディング
vim.api.nvim_create_autocmd('LspAttach', { callback = require('util.fold').set })

--- 各種プラグイン設定
require('plugin.mini').setup() -- `load` は mini.deps 依存のため 先にplugin.miniをsetupしておく.
local load = require('plugin.mini').load

-- neovimでmpdを制御する自作プラグイン
load({ source = 'ozoramore/nvimpc.lua' }, require('plugin.mpc').setup, true)

-- 外観
load({ source = 'folke/styler.nvim' }, require('plugin.styler').setup, true)
load({ source = 'lewis6991/gitsigns.nvim' }, require('plugin.gitsigns').setup, true)
load({ source = 'luukvbaal/statuscol.nvim' }, require('plugin.statuscol').setup)

-- DAP/treesitter/lspなど、外部コマンドに依存する系の設定
if vim.fn.has('unix') == 1 then
	load({ source = 'mfussenegger/nvim-dap' }, require('plugin.dap').setup, true)
	load({ source = 'nvim-treesitter/nvim-treesitter' }, require('plugin.treesitter').setup, true)
	load({ source = 'neovim/nvim-lspconfig' }, require('plugin.lsp').setup, true)
end
