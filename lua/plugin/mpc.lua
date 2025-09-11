local M = {}

local displaySong = function(tbl) return string.format('%2d: %s / %s - %s', tbl.Track, tbl.Title, tbl.Artist, tbl.Album) end

M.setup = function()
	local conf = { host = os.getenv('MPD_HOST'), port = os.getenv('MPD_PORT') }
	if conf.host == nil then return end
	local mpc = require('nvimpc')
	mpc.setup(conf)

	local printsongs = function(result)
		local mpc_util = require('nvimpc.util')
		local t = {}
		for _, v in mpc_util.devide(result) do table.insert(t, displaySong(v)) end
		mpc_util.printer(t)
	end

	vim.api.nvim_create_user_command('MpcNowPlaying', mpc.gen('currentsong', printsongs), {})
	vim.api.nvim_create_user_command('MpcQueue', mpc.gen('playlistinfo', printsongs), {})
end

return M
