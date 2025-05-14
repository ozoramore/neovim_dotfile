if vim.fn.executable('wl-copy') == 0 then
	print('wl-clipboard not found')
else
	local function win32yank(cmd)
		local exe = { '/mnt/c/Program Files/Neovim/bin/win32yank.exe', cmd }
		return { ['+'] = exe, ['*'] = exe }
	end
	vim.g.clipboard = { name = 'win32yank', copy = win32yank('-i'), paste = win32yank('-o'), cache_enabled = true }
end

vim.api.nvim_create_autocmd('InsertLeave', {
	group = vim.api.nvim_create_augroup('conf_ime', {}),
	callback = function() vim.system({ '/opt/zenhan/zenhan.exe', '0' }) end
})
