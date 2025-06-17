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

local FILETYPE = {}

FILETYPE.setup = function(config)
	config = config or {}
	vim.filetype.add({ extension = set_ext(config) })
end

return FILETYPE
