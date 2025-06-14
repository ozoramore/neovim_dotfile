-- filetype.lua
-- author: ozoramore
--
-- ファイルタイプの設定
--

local M = {}

local set_ext = function(args)
	local ext = {}
	for key, t in pairs(args) do
		for _, value in ipairs(t) do ext[value] = key end
	end
	return ext
end

M.setup = function(config)
	config = config or {}
	vim.filetype.add({ extension = set_ext(config) })
end

return M
