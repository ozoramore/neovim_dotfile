local M = {}

M.setup = function()
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'c', 'cpp', 'rust', 'bash', 'lua', 'python',
			'ruby', 'vue', 'typescript', 'javascript', 'html', 'markdown',
			'vimdoc', 'css', 'xml', 'toml', 'yaml',
		},
		highlight = { enable = true },
		incremental_selection = { enable = true },
		indent = { enable = true },
		textobjects = { enable = true },
	})
end

return M
