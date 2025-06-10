-- indent.lua
-- author: ozoramore
--
-- バッファのファイルタイプに応じて
-- - インデント幅
-- - ソフトタブかハードタブか
-- を切り替える。
--

local M = {}

local function set(arr)
	vim.bo.expandtab = arr.is_expand
	vim.bo.tabstop = arr.tabstop
	vim.bo.shiftwidth = 0
	vim.bo.softtabstop = -1
end

M.setup = function(configs)
	local config = configs.config or {}
	local default = configs.default or { tabstop = 4, is_expand = true }

	local function def() return default end
	local function callback(args)
		set(setmetatable(config, { __index = def })[args.match])
	end
	vim.api.nvim_create_autocmd('FileType', { callback = callback })
end

return M
