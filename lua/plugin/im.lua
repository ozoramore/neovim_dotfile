local M = {}

local function wsl_im_conf()
	if vim.fn.executable('wl-copy') ~= 0 then
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
end

local function native_im_conf()
	require('plugin.loader').load('h-hg/fcitx.nvim', nil)
end

local is_wsl = vim.fn.has('wsl') == 1

M.setup = is_wsl and wsl_im_conf or native_im_conf

return M
