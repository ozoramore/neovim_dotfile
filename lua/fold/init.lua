-- fold
-- author ozoramore
--
-- foldexprを選択する. 順番は以下の通り
-- 1. LSP
-- 2. treesitter

local set_lsp = require('fold.lsp').set
local set_ts = require('fold.treesitter').set

local FOLD = {}

FOLD.set = function(args)
	if set_lsp(args.buf) then return end
	if set_ts(args.buf) then return end
end

return FOLD

