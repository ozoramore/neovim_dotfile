-- filetype.lua
-- author: ozoramore
--
-- ファイルタイプの設定
--

local set_ext = function(args)
	local ext = {}
	for k, t in pairs(args) do for _, v in ipairs(t) do ext[v] = k end end
	return ext
end

local set_buf_opts = function(conf)
	require('util.option').setbufopts(conf)
end

local default_bufopts = {
	tabstop = 4,
	expandtab = true,
	shiftwidth = 0,
	softtabstop = -1,
}

local FILETYPE = {}

FILETYPE.setup = function(config)
	config = config or {}
	vim.filetype.add({ extension = set_ext(config) })
end

FILETYPE.config = function(o)
	local default = vim.tbl_deep_extend('force', default_bufopts, o.default)

	local defaults = function() return default end
	local callback = function(t) set_buf_opts(setmetatable(o.config, { __index = defaults })[t.match]) end

	vim.api.nvim_create_autocmd('FileType', { callback = callback })
end

return FILETYPE
