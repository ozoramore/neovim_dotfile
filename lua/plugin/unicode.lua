local M = {}

local footprint = require('util.bufstr')

local cp_search = function(tbl, chr)
	if not chr then return nil end
	for _, t in ipairs(tbl) do
		if chr == t[2] then return t end
	end
	return nil
end

local printer = function(cp)
	print(string.format('\'%s\'[0x%X]: %s', cp[2], vim.fn.char2nr(cp[2]), cp[1]))
end

local info = function(tbl)
	local fp = footprint.get()
	if not fp then return end
	printer(cp_search(tbl, fp) or { 'no data', fp })
end

local ismatch = function(s1, s2)
	local function sur_sp(s) return ' ' .. s .. ' ' end
	local chkchar = function(s) return (vim.fn.strlen(s) == 1) end
	if not chkchar(s1) and not chkchar(s2) then s1, s2 = string.lower(s1), string.lower(s2) end
	return sur_sp(s1):match(sur_sp(s2))
end

local name_search = function(tbl, str)
	local tb = {}
	for _, t in ipairs(tbl) do if ismatch(t[1], str) then table.insert(tb, t) end end
	return tb
end

local search = function(tbl, str)
	local s = table.concat(str)
	local t = name_search(tbl, s)
	local c = cp_search(tbl, s)
	if c and (#t < 1 or t[1][2] ~= c[2]) then table.insert(t, 1, c) end
	for i, cp in ipairs(t) do
		printer(cp)
		if i > 20 then
			print(string.format('there are %d more items...', #t - i))
			return
		end
	end
end

M.setup = function()
	local u = require('unicode-search').unicode_data
	vim.api.nvim_create_user_command('Usearch', function(opts) search(u, opts.fargs) end, { nargs = '+' })
	vim.api.nvim_create_user_command('Uinfo', function() info(u) end, {})
end

return M
