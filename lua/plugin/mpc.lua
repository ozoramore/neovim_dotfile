local M = {}
local lead_filter = function(l) return function(i) return vim.startswith(i, l) end end

M.setup = function()
	local mpc = require('nvimpc')
	local host = os.getenv('MPD_HOST') or 'localhost'
	local port = tonumber(os.getenv('MPD_PORT') or 6600)
	mpc.setup({ host = host, port = port })
	local comp_common = function(l, _, _) return vim.tbl_filter(lead_filter(l), mpc.commands) end
	vim.api.nvim_create_user_command('Mpc', mpc.print, { nargs = '?', complete = comp_common })
	vim.api.nvim_create_user_command('MpcNowPlaying', mpc.nowplaying, {})
	vim.api.nvim_create_user_command('MpcQueue', mpc.queue, {})
end

return M
