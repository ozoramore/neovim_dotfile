local ns = vim.api.nvim_create_namespace("LineNumberGroup")
vim.diagnostic.config(
	{
		signs = {
			text = {
				[1] = " ",
				[2] = " ",
				[3] = " ",
				[4] = " ",
				[5] = " ",
			},
			numhl = {
				[1] = "LineNumberGroup1",
				[2] = "LineNumberGroup2",
				[3] = "LineNumberGroup3",
				[4] = "LineNumberGroup4",
				[5] = "LineNumberGroup5",
			}
		},
		underline = false,
	},
	ns)

local lnumcb = function()
	vim.diagnostic.reset(ns, 0)
	local diag = vim.diagnostic.get(0)
	local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
	table.insert(diag, { lnum = current_line - 20, col = 0, severity = 4 })
	table.insert(diag, { lnum = current_line + 20, col = 0, severity = 4 })
	table.insert(diag, { lnum = current_line - 15, col = 0, severity = 3 })
	table.insert(diag, { lnum = current_line + 15, col = 0, severity = 3 })
	table.insert(diag, { lnum = current_line - 10, col = 0, severity = 2 })
	table.insert(diag, { lnum = current_line + 10, col = 0, severity = 2 })
	table.insert(diag, { lnum = current_line -  5, col = 0, severity = 1 })
	table.insert(diag, { lnum = current_line +  5, col = 0, severity = 1 })
	vim.diagnostic.set(ns, 0, diag, {})
end

vim.api.nvim_create_autocmd(
	{ 'TextChanged', 'TextChangedT', 'BufRead', 'BufNewFile', 'CursorMoved', 'CursorMovedI' },
	{ callback = lnumcb }
)
