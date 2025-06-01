local M = {}

function M.setup()
	local function signs(ns, add_sign)
		local sign = { namespace = { ns }, maxwidth = 1, colwidth = 1, auto = false }
		for k, v in pairs(add_sign) do sign[k] = v end
		return { sign = sign, click = 'v:lua.ScSa' }
	end
	require('statuscol').setup({
		bt_ignore = { 'terminal', 'nofile' },
		relculright = true,
		segments = {
			signs('diagnostic', {}),
			signs('Dap*', {}),
			{ text = { require('statuscol.builtin').lnumfunc }, click = 'v:lua.ScLa' },
			{ text = { require('statuscol.builtin').foldfunc }, click = 'v:lua.ScFa' },
			signs('git.*', { wrap = true, fillchar = '│', fillcharhl = 'NonText' }),
		}
	})
end

return M
