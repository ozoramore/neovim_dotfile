local options = {
	incsearch = true,
	backup = false,
	swapfile = false,
	encoding = "utf-8",
	fileencoding = "utf-8",
	fileencodings = "utf-8,sjis,iso-2022-jp,euc-jp,default",
	fileformat = "unix",
	fileformats = "unix,dos,mac",
	langmenu = "C.utf-8",
	helplang = 'ja,en',
	completeopt = 'menu,menuone,noselect,popup',
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd('language C.utf-8')

vim.g.mapleader = ","

