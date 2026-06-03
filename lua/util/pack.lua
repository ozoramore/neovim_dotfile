-- pack.lua
-- use builtin package manager.

local load_now = function(load) pcall(load) end
local load_later = function(load)
	pcall(vim.api.nvim_create_autocmd, { 'FileType' }, { callback = load })
end

local M = {}

M.load = function(setup, do_it_later)
	if do_it_later then
		load_later(setup)
	else
		load_now(setup)
	end
end

M.clean = function()
	local packs = {}
	for _, p in ipairs(vim.pack.get()) do
		if not p.active then
			table.insert(packs, p.spec.name)
		end
	end
	if #packs > 0 then
		vim.pack.del(packs)
	end
end

return M
