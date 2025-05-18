local M = {}

M.if_a_else_b = function(cond, a, b)
	if cond then
		return a
	else
		return b
	end
end

return M
