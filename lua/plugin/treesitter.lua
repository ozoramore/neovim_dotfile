local TS = {}

local installed = {
	'bash',
	'c',
	'cpp',
	'css',
	'html',
	'javascript',
	'lua',
	'markdown',
	'python',
	'ruby',
	'rust',
	'toml',
	'typescript',
	'vimdoc',
	'vue',
	'xml',
	'yaml',
	'zig',
}

TS.setup = function()
	require('nvim-treesitter.configs').setup({
		ensure_installed = installed,
		highlight = { enable = true },
		incremental_selection = { enable = true },
		indent = { enable = true },
		textobjects = { enable = true },
	})
end

return TS
