local M = {}


M.setup = require('plugin.mini').packadd

M.load = function(src, setup)
	require('plugin.mini').deps.now(function()
		if src then require('plugin.mini').deps.add({ source = src }) end
		if setup then setup() end
	end)
end

return M
