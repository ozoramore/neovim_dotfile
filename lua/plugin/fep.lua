local M = {}

local fn = require('util').fn

local function wsl_im_conf()
	if vim.fn.executable('wl-copy') ~= 0 then
		local function win32yank(cmd)
			local exe = { '/mnt/c/Program Files/Neovim/bin/win32yank.exe', cmd }
			return { ['+'] = exe, ['*'] = exe }
		end
		vim.g.clipboard = {
			name = 'win32yank',
			copy = win32yank('-i'),
			paste = win32yank('-o'),
			cache_enabled = true
		}
	end

	vim.api.nvim_create_autocmd('InsertLeave', {
		group = vim.api.nvim_create_augroup('conf_ime', {}),
		callback = fn({ '/opt/zenhan/zenhan.exe', '0' })
	})
end

local function windows_im_conf()
	vim.api.nvim_create_autocmd('InsertLeave', {
		group = vim.api.nvim_create_augroup('conf_ime', {}),
		callback = fn({ 'C:/FreeSoft/zenhan/zenhan.exe', '0' })
	})
end

local function fcitx_conf()
	require('plugin.loader').load('h-hg/fcitx.nvim', nil)
end

local fep = {
	{ env = 'wsl',     func = wsl_im_conf },
	{ env = 'unix',    func = fcitx_conf },
	{ env = 'windows', func = windows_im_conf }
}

M.setup = require('util').sel_by_env(fep)

return M
