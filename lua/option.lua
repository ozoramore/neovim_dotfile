-- option.lua
-- author ozoramore

local M = {}

M.setopts = function(opts)
	for k, v in pairs(opts) do
		vim.opt[k] = v
	end
end

M.setcmds = function(cmds)
	for k, v in pairs(cmds) do
		vim.cmd[k](v)
	end
end

M.setvals = function(vals)
	for k, v in pairs(vals) do
		vim.g[k] = v
	end
end

return M
