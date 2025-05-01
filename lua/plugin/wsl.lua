if vim.fn.executable('wl-copy') == 0 then
	print("wl-clipboard not found, clipboard integration won't work")
else
	vim.g.clipboard = {
		name = 'win32yank',
		copy = {
			['+'] = { '/mnt/c/Program Files/Neovim/bin/win32yank.exe', '-i' },
			['*'] = { '/mnt/c/Program Files/Neovim/bin/win32yank.exe', '-i' },
		},
		paste = {
			['+'] = { '/mnt/c/Program Files/Neovim/bin/win32yank.exe', '-o' },
			['*'] = { '/mnt/c/Program Files/Neovim/bin/win32yank.exe', '-o' },
		},
		cache_enabled = true
	}
end

vim.api.nvim_create_autocmd('InsertLeave', {
	group = vim.api.nvim_create_augroup('conf_ime', {}),
	callback = function() vim.system({ '/opt/zenhan/zenhan.exe', '0' }) end
})
