local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({ source = 'nvim-treesitter/nvim-treesitter' })

add({ source = 'neovim/nvim-lspconfig', })
-- add({ source = 'hrsh7th/nvim-cmp', })
-- add({ source = 'hrsh7th/cmp-nvim-lsp', })
-- add({ source = 'hrsh7th/cmp-path', })
add({ source = 'rhysd/vim-clang-format', })

add({ source = 'gmartsenkov/root.nvim', })

add({ source = 'h-hg/fcitx.nvim' })

add({ name = 'mini.nvim', checkout = 'HEAD' })

now(function()
	require('mini.completion').setup()
	local imap_expr = function(lhs, rhs)
		vim.keymap.set('i', lhs, rhs, { expr = true })
	end
	imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
	imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
end
)
require('mini.files').setup({ mappings = { go_in_plus = '<CR>', }, })
vim.api.nvim_create_user_command('Fo',function() MiniFiles.open() end,{})
require('mini.pairs').setup()

require("lspconfig").clangd.setup {
	cmd = {
		"/bin/clangd",
		"--header-insertion=never",
		"--clang-tidy",
		"--enable-config",
	}
}

require("root").setup {
	patterns = {".git" }
}

require("nvim-treesitter.configs").setup({
	ensure_installed = { 'bash', 'c', 'cpp', 'css', 'html', 'lua', 'markdown', 'markdown_inline', 'python', 'regex', 'toml', 'yaml', 'vim', 'vimdoc', },
	highlight = { enable = true },
	incremental_selection = { enable = true },
	indent = { enable = true },
	textobjects = { enable = true },
})
