local M = {}

local footprint = require('util.bufstr')

local cp_search = function(tbl, chr)
	for _, t in ipairs(tbl) do
		if chr == t[2] then return t end
	end
	return { nil, nil }
end

local printer = function(tbl)
	vim.print(tbl)
end

local info = function(tbl)
	local chr = footprint.get()
	if not chr then return end
	print(chr .. ':' .. cp_search(tbl, chr)[1])
end

local name_search = function(tbl, str)
	local tb = {}
	for _, t in ipairs(tbl) do
		if t[1]:match(str) then
			table.insert(tb, t)
			if #tb > 20 then return tb end
		end
	end
	return tb
end

local search = function(tbl, str)
	local s = table.concat(str)
	if #vim.str_utf_pos(s) == 1 then
		printer(cp_search(tbl, s))
	else
		printer(name_search(tbl, s))
	end
end

M.setup = function()
	local u = require('unicode-search').unicode_data
	vim.api.nvim_create_user_command('Usearch', function(opts) search(u, opts.fargs) end, { nargs = '+' })
	vim.api.nvim_create_user_command('Uinfo', function() info(u) end, {})
end

return M
