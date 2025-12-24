local M = {}

local display_song = function(tbl) return string.format('%s / %s - %s', tbl.Title, tbl.Artist, tbl.Album) end

local print_songs = function(result)
	local mpc_util = require('nvimpc.util')
	local t = {}
	for _, v in mpc_util.devide(result) do table.insert(t, display_song(v)) end
	mpc_util.printer(t)
end

M.setup = function()
	local conf = { host = os.getenv('MPD_HOST'), port = os.getenv('MPD_PORT') }
	if conf.host == nil then return end
	local mpc = require('nvimpc')
	mpc.setup(conf)

	vim.api.nvim_create_user_command('MpcNowPlaying', mpc.gen('currentsong', print_songs), {})
	vim.api.nvim_create_user_command('MpcQueue', mpc.gen('playlistinfo', print_songs), {})
end

return M
