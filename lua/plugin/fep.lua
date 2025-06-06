local set_insertleave = function(cmd)
	vim.api.nvim_create_autocmd('InsertLeave', {
		callback = function(_) vim.system(cmd) end
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
	set_insertleave({ '/opt/zenhan/zenhan.exe', '0' })
end

local function fcitx_conf()
	require('plugin.mini').deps.load('h-hg/fcitx.nvim', nil)
end

local function windows_im_conf()
	set_insertleave('C:/FreeSoft/zenhan/zenhan.exe')
end

local fep = {
	{ env = 'wsl',     func = wsl_im_conf },
	{ env = 'unix',    func = fcitx_conf },
	{ env = 'windows', func = windows_im_conf }
}

local FEP = {}

function FEP.setup()
	for _, val in pairs(fep) do
		if vim.fn.has(val.env) == 1 then
			return val.func()
		end
	end
	return nil
end

return FEP
