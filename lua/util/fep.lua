local check_exec = function(fep)
	if vim.fn.executable(fep) == 1 then return fep else return nil end
end

local set_insertleave = function(cmd)
	vim.api.nvim_create_autocmd('InsertLeave', {
		callback = function(_) vim.system(cmd) end
	})
end

local set_w32y = function(path)
	local function win32yank(cmd)
		local exe = { path, cmd }
		return { ['+'] = exe, ['*'] = exe }
	end
	vim.g.clipboard = {
		name = 'win32yank',
		copy = win32yank('-i'),
		paste = win32yank('-o'),
		cache_enabled = true
	}
end

local function wsl_im_conf()
	local w32y = check_exec('win32yank.exe')
	if w32y then set_w32y(w32y) end
	local fep = check_exec('zenhan.exe')
	if fep then set_insertleave({ fep, '-0' }) end
end

local function fcitx_conf()
	local fep = check_exec('fcitx-remote') or check_exec('fcitx5-remote')
	if fep then set_insertleave({ fep, '-c' }) end
end

local function windows_im_conf()
	local w32y = check_exec('win32yank.exe')
	if w32y then set_w32y(w32y) end
	local fep = check_exec('zenhan.exe')
	if fep then set_insertleave({ fep, '-0' }) end
end

local fep = {
	{ env = 'wsl',     func = wsl_im_conf },
	{ env = 'unix',    func = fcitx_conf },
	{ env = 'windows', func = windows_im_conf }
}

local FEP = {}

function FEP.setup()
	for _, val in pairs(fep) do
		if vim.fn.has(val.env) == 1 then return val.func() end
	end
	return nil
end

return FEP
