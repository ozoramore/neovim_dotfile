local M = {}

local git_signs = {
	add          = { text = '║' },
	change       = { text = '┃' },
	delete       = { text = '⎣' },
	topdelete    = { text = '⎡' },
	changedelete = { text = '╪' },
	untracked    = { text = '┆' },
}

function M.setup()
	require('gitsigns').setup({ signs = git_signs, signs_staged = git_signs })
end

return M
