local M = {}
local lead_filter = function(a)
	return function(i)
		return vim.startswith(i, a) or vim.startswith(i, '"' .. a)
	end
end

local split = function(str, ts)
	local t = {}
	local ptn = '([^' .. (ts or '\n') .. ']+)'
	for s in string.gmatch(str, ptn) do table.insert(t, s) end
	return t
end

M.setup = function()
	local mpc = require('nvimpc')
	mpc.setup({ host = os.getenv('MPD_HOST'), port = os.getenv('MPD_PORT') })
	local cmp_command = function(a, _, _) return vim.tbl_filter(lead_filter(a), mpc.commands) end
	local cmp_files = function(a, _, _) return vim.tbl_filter(lead_filter(a), mpc.files) end

	local cmp = function(a, l, p)
		local t = split(l, ' ')
		if #t < 2 or (#t == 2 and a ~= "") then return cmp_command(a, l, p) end
		if t[2] == 'add' then return cmp_files(a, l, p) end
		if t[2] == 'listfiles' then return cmp_files(a, l, p) end
		return nil
	end

	vim.api.nvim_create_user_command('Mpc', mpc.print, { nargs = '*', complete = cmp })
	vim.api.nvim_create_user_command('MpcNowPlaying', mpc.nowplaying, {})
	vim.api.nvim_create_user_command('MpcQueue', mpc.queue, {})
end

return M
