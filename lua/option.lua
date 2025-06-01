-- option.lua
-- author ozoramore
--
-- `vim.opt` 系の設定

local M = {}

local opt = {
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
	ambiwidth = 'single',
	number = true,
	showmatch = true,
	termguicolors = true,
	laststatus = 3,
	bg = 'dark',
	list = true,
	fillchars = { fold = ' ', foldopen = '┌', foldsep = '│', foldclose = '─' },
	listchars = { tab = '>-', trail = '_', extends = '>', precedes = '<', nbsp = '%' },
}

local function setopts(dict)
	for k, v in pairs(dict) do vim.opt[k] = v end
end
M.setup = function()
	setopts(opt)
	vim.cmd.language('en_US.utf-8') -- TODO: 消したい
end

return M
