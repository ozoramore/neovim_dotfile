local M = {}

local fn = function(cmd)
	return function() vim.system(cmd) end
end

local set_zenhan = function(path)
	vim.api.nvim_create_autocmd('InsertLeave', {
		group = vim.api.nvim_create_augroup('conf_ime', {}),
		callback = fn({ path, '0' })
	})
end

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
	set_zenhan('/opt/zenhan/zenhan.exe')
end

local function windows_im_conf()
	set_zenhan('C:/FreeSoft/zenhan/zenhan.exe')
end

local function fcitx_conf()
	require('plugin').load('h-hg/fcitx.nvim', nil)
end

local fep = {
	{ env = 'wsl',     func = wsl_im_conf },
	{ env = 'unix',    func = fcitx_conf },
	{ env = 'windows', func = windows_im_conf }
}

function M.setup()
	for _, val in pairs(fep) do
		if vim.fn.has(val.env) == 1 then
			return val.func
		end
	end
	return nil
end

return M
