local M = {}
local if_a_else_b = require('util').if_a_else_b

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

	local function zenhan()
		vim.system({ '/opt/zenhan/zenhan.exe', '0' })
	end

	vim.api.nvim_create_autocmd('InsertLeave', {
		group = vim.api.nvim_create_augroup('conf_ime', {}),
		callback = zenhan
	})
end

local function native_im_conf()
	require('plugin.loader').load('h-hg/fcitx.nvim', nil)
end

local is_wsl = vim.fn.has('wsl') == 1

M.setup = if_a_else_b(is_wsl, wsl_im_conf, native_im_conf)

return M
