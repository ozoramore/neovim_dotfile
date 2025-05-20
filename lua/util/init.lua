local M = {}

M.if_a_else_b = function(cond, a, b)
	if cond then
		return a
	else
		return b
	end
end

M.fn = function(cmd)
	return function() vim.system(cmd) end
end

M.sel_by_env = function(dict)
	for _, val in pairs(dict) do
		if vim.fn.has(val.env) == 1 then
			return val.func
		end
	end
	return nil
end

return M
