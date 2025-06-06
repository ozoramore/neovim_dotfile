local TYPE_START = 1
local TYPE_END = 2

local function set_opval(opt, val)
	vim.api.nvim_set_option_value(opt, val, { scope = 'local' })
end

local function is_foldable_symbol(symbol)
	local range = symbol.range
	local k = vim.lsp.protocol.SymbolKind
	local kind = symbol.kind

	if range['end'].line - range.start.line < vim.wo.foldminlines then return false end
	local not_foldable =
		kind == k.Property or
		kind == k.Field or
		kind == k.Variable or
		kind == k.Constant or
		kind == k.EnumMember
	return not not_foldable
end

local calculate_folds = function(_, _, _, _) end

local function check_calc_folds(folds, symbol, level, max_level)
	if not is_foldable_symbol(symbol) then return end

	local folds_start = symbol.range.start.line + 1
	local folds_end = symbol.range['end'].line + 1
	local start_fold = { type = TYPE_START, level = level, symbol = symbol }
	local end_fold = { type = TYPE_END, level = level, symbol = symbol }

	if folds[folds_start] == nil then level = level + 1 end
	folds[folds_start] = folds[folds_start] or start_fold
	if symbol.children and level <= max_level then
		calculate_folds(folds, symbol.children, level, max_level)
	end
	folds[folds_end] = end_fold
end

calculate_folds = function(folds, symbols, lv, cap)
	for _, s in pairs(symbols) do check_calc_folds(folds, s, lv, cap) end
end

local function configure_fold_options()
	set_opval('foldmethod', 'expr')
	set_opval('foldexpr', 'v:lua.require(\'lsp.fold\').foldexpr(v:lnum)')
	set_opval('foldtext', 'v:lua.require(\'lsp.fold\').foldtext(v:foldstart, v:foldend, v:folddashes)')
end

local function update_fold(bufnr, top, bottom)
	for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
		if vim.wo[win].foldmethod == 'expr' then vim._foldupdate(win, top, bottom) end
	end
end

local function request_update_fold(bufnr)
	local function buf_update_fold() update_fold(bufnr, 0, vim.api.nvim_buf_line_count(bufnr)) end
	local function is_loaded_fold() if vim.api.nvim_buf_is_loaded(bufnr) then buf_update_fold() end end
	local augroup = vim.api.nvim_create_augroup('LSPFold', {})
	if vim.api.nvim_get_mode().mode:match('^i') then return vim.schedule(is_loaded_fold) end
	if #(vim.api.nvim_get_autocmds({ group = augroup, buffer = bufnr })) > 0 then return end
	local autocmd = { group = augroup, buffer = bufnr, once = true, callback = buf_update_fold }
	vim.api.nvim_create_autocmd('InsertLeave', autocmd)
end

local function restore_fold_options(state)
	set_opval('foldmethod', state.original_foldmethod)
	set_opval('foldexpr', state.original_foldexpr)
	set_opval('foldtext', state.original_foldtext)
end

local function get_document_symboles(bufnr, state, changedtick)
	local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr), }
	local function callback(responses)
		state.request = nil
		if not responses or state.version ~= changedtick then return nil end
		local new_folds = {}
		local max_level = vim.wo.foldnestmax
		for _, response in pairs(responses) do
			if response.result then
				calculate_folds(new_folds, response.result, 1, max_level)
			end
		end
		request_update_fold(bufnr)
		state.folds = new_folds
	end
	if state.request then state.request() end
	state.request = vim.lsp.buf_request_all(bufnr, 'textDocument/documentSymbol', params, callback)
	state.version = changedtick
end

local function new_state()
	return {
		folds = {},
		levels = {},
		original_foldmethod = vim.api.nvim_get_option_value('foldmethod', { scope = 'local' }),
		original_foldexpr = vim.api.nvim_get_option_value('foldexpr', { scope = 'local' }),
		original_foldtext = vim.api.nvim_get_option_value('foldtext', { scope = 'local' }),
		detached = false,
		version = 0,
	}
end

local fold_states = {}

local function attach_on_lines(_, bufnr, changedtick)
	local fold_state = fold_states[bufnr]
	if not fold_state then return nil end

	get_document_symboles(bufnr, fold_state, changedtick)
	return fold_state.detached
end

local function attach_on_reload(_, bufnr)
	return attach_on_lines(nil, bufnr, vim.api.nvim_buf_get_changedtick(bufnr))
end

local function attach_on_detach(_, bufnr)
	local fold_state = fold_states[bufnr]
	if not fold_state then return nil end

	if fold_state.request then fold_state.request() end
	fold_state.request = nil

	if vim.api.nvim_buf_is_loaded(bufnr) then restore_fold_options(fold_state) end
	fold_states[bufnr] = nil
end

local M = {}

function M.attach(bufnr)
	-- This buffer has already been setup. So reuse the state that already exists and abort detaching.
	if fold_states[bufnr] then
		fold_states[bufnr].detached = false; return
	end

	local attach_act = { on_lines = attach_on_lines, on_reload = attach_on_reload, on_detach = attach_on_detach }
	vim.api.nvim_buf_attach(bufnr, false, attach_act)

	fold_states[bufnr] = new_state()

	configure_fold_options()
	get_document_symboles(bufnr, fold_states[bufnr], vim.api.nvim_buf_get_changedtick(bufnr))
end

-- vim.api.nvim_buf_detach() is only available with RPC. Instead, detach from callbacks.
function M.detach(bufnr) if fold_states[bufnr] then fold_states[bufnr].detached = true end end

function M.foldexpr(lnum)
	local bufnr = vim.api.nvim_get_current_buf()
	local state = fold_states[bufnr]
	local fold = state.folds[lnum]

	if state == nil then
		return -1
	elseif fold == nil then
		return state.levels[lnum] or '='
	elseif fold.type == TYPE_START then
		return '>' .. fold.level
	else
		return '<' .. fold.level
	end
end

function M.foldtext(fold_start, fold_end, fold_dashes)
	local bufnr = vim.api.nvim_get_current_buf()
	local fold = fold_states[bufnr].folds[fold_start]

	if not fold_states[bufnr] or not fold then return '' end

	local start_line = fold.symbol.selectionRange.start.line
	local length = fold.symbol.range['end'].line - fold.symbol.range.start.line
	local line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1] or ''
	local trim = function(s) return s:gsub('^%s+', ''):gsub('%s+$', '') end

	return string.format('+-%s%3d lines: %s', fold_dashes, length, trim(line))
end

function M.get_state(bufnr)
	return fold_states[bufnr or vim.api.nvim_get_current_buf()]
end

function M.set(buf)
	local client = vim.lsp.get_clients({ buf })[1]
	local has_fold = client and client:supports_method('textDocument/completion')

	if has_fold then configure_fold_options() end
	return has_fold
end

return M
