local options = {
	ambiwidth = 'single',
	tabstop = 4,
	shiftwidth = 4,
	number = true,
	showmatch = true,
	termguicolors = false,
	bg = 'dark',
	list = true,
	listchars = { tab = '>-', trail = '_' ,extends = '>', precedes = '<', },
}

vim.cmd.colorscheme('vim')
for k, v in pairs(options) do
	vim.opt[k] = v
end
