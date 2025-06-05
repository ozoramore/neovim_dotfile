local SNIPS = {}

local snips = require('mini.snippets')

-- Do not match with whitespace to cursor's left
local function match_strict(s) return snips.default_match(s, { pattern_fuzzy = '%S+' }) end

local function snippets_stop()
	local function all_stop() while snips.session.get() do snips.session.stop() end end
	vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*:n', once = true, callback = all_stop })
end

local function expand_or_jump(key, expand_key, jump)
	if vim.fn.pumvisible() ~= 0 then
		return expand_key
	elseif snips.session.get() then
		snips.session.jump(jump); return ''
	else
		return key
	end
end

local function supertab()
	if #snips.expand({ insert = false }) > 0 then
		vim.schedule(snips.expand)
		return ''
	end
	return expand_or_jump('<Tab>', '<C-n>', 'next')
end

local function supertab_s()
	return expand_or_jump('<S-Tab>', '<C-p>', 'prev')
end


SNIPS.setup = function()
	require('mini.snippets').setup({
		mappings = { expand = '', jump_next = '', jump_prev = '' },
		expand = { match = match_strict }
	})
	vim.api.nvim_create_autocmd('User', { pattern = 'MiniSnippetsSessionStart', callback = snippets_stop })
	vim.keymap.set('i', '<Tab>', supertab, { expr = true })
	vim.keymap.set('i', '<S-Tab>', supertab_s, { expr = true })
end

return SNIPS
