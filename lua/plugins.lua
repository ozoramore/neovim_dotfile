local add, now = MiniDeps.add, MiniDeps.now add({ name = 'mini.nvim', checkout = 'HEAD' })
require('mini.pairs').setup()

add({ source = 'cameron-wags/rainbow_csv.nvim' })
require('rainbow_csv').setup()

add({ source = 'akinsho/toggleterm.nvim' })
now(function()
	require('toggleterm').setup({
		hide_numbers = true,
		direction = 'float',
		start_in_insert = true,
		insert_mappings = true,
	})
end)

add({ source = 'lewis6991/gitsigns.nvim' })
now(function()
	require('gitsigns').setup({
		signs = {
			add = { text = '┃' },
			change = { text = '┃' },
			delete = { text = '↳' },
			topdelete = { text = '↱' },
			changedelete = { text = '╪' },
			untracked = { text = '┆' },
		},
		signs_staged = {
			add = { text = '┃' },
			change = { text = '┃' },
			delete = { text = '↳' },
			topdelete = { text = '↱' },
			changedelete = { text = '╪' },
			untracked = { text = '┆' },
		},
	})
end)

if vim.fn.has("unix") == 1 then
	require( "for_linux" )
end
