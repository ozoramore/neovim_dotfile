local M = {}

M.setup = function()
	local conf = {  host = os.getenv('MPD_HOST'), port = os.getenv('MPD_PORT') }
	if conf.host == nil then return end
	local mpc = require('nvimpc')
	mpc.setup(conf)
	local mpc_util = require('nvimpc.util')
	vim.api.nvim_create_user_command('MpcNowPlaying', mpc.gen('currentsong', mpc_util.printer), {})
	vim.api.nvim_create_user_command('MpcQueue', mpc.gen('playlistinfo', mpc_util.printer), {})
end

return M
