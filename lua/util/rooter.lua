local M = {}

local root_patterns = { ".git", ".clang-format", ".vscode" }
M.root_dir = function(p)
	local find_result = vim.fs.find(root_patterns, { upward = true, type = 'directory', path = p })
	if not find_result[1] then return nil end
	return vim.fs.dirname(find_result[1])
end

return M
