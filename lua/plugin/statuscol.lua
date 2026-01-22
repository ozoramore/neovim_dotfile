local function signs(ns, add_sign)
	local sign = { maxwidth = 1, colwidth = 1, auto = false, namespace = { ns } }
	return { sign = vim.tbl_deep_extend('force', sign, add_sign), click = 'v:lua.ScSa' }
end

local diag_signs = {
	[vim.diagnostic.severity.ERROR] = "✗",
	[vim.diagnostic.severity.WARN]  = "⚠",
	[vim.diagnostic.severity.INFO]  = "◆",
	[vim.diagnostic.severity.HINT]  = "*",
}

local dap_signs = {
	['DapBreakpoint']          = '●',
	['DapBreakpointCondition'] = '◑',
	['DapBreakpointRejected']  = '◌',
	['DapLogPoint']            = '◩',
	['DapStopped']             = '▶',
}

local sign_def_diag = function(tbl)
	vim.diagnostic.config({ signs = { text = tbl } })
end

local function sign_def(tbl)
	for name, text in pairs(tbl) do
		vim.fn.sign_define(name, { text = text })
	end
end

local STATUSCOL = {}

function STATUSCOL.setup()
	local builtin = require('statuscol.builtin')
	local ignore = { 'terminal', 'nofile', 'help' }
	local diag = signs('diagnostic', { serverity_sort = true })
	local dap = signs(nil, { name = { 'Dap.*' } })
	local lnum = { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' }
	local fold = { text = { builtin.foldfunc }, click = 'v:lua.ScFa' }
	local git = signs('gitsigns', { wrap = true, fillchar = '│', fillcharhl = 'NonText' })

	sign_def_diag(diag_signs)
	sign_def(dap_signs)

	require('statuscol').setup({ bt_ignore = ignore, segments = { diag, dap, lnum, fold, git } })
end

return STATUSCOL
