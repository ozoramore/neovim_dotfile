local lnumfunc = function(lnum, current_line)
	local range = math.abs(lnum - current_line)
	if range == 5 then return 'LineNrGroup1' end
	if range == 10 then return 'LineNrGroup2' end
	if range == 20 then return 'LineNrGroup2' end
	if range % 50 == 0 then return 'LineNrGroup3' end
	return nil
end

local M = {}

M.setup = function()
	require('lnum_color').setup(10, lnumfunc)
end

return M
