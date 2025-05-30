local M = {}

M.setup = function()
	local mpc = require('nvimpc')
	local host = os.getenv('MPD_HOST') or 'localhost'
	local port = tonumber(os.getenv('MPD_PORT') or 6600)
	mpc.setup({ host = host, port = port })
	vim.api.nvim_create_user_command('Mpc', mpc.exec, { nargs = '?' })
	vim.api.nvim_create_user_command('MpcNowPlaying', mpc.nowplaying, {})
	vim.api.nvim_create_user_command('MpcQueue', mpc.queue, {})
end

return M
