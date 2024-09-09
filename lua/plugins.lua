require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup {}
	end,
	require("lspconfig").clangd.setup {
		cmd = {
			"/bin/clangd",
			"--header-insertion=never",
			"--clang-tidy",
			"--enable-config",
		}
	}
}

require("root").setup {
	patterns = {".git" }
}

local function cmp_setup()
	local cmp = require('cmp')
	require('cmp').setup({
		mapping = cmp.mapping.preset.insert({
			["<Tab>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			--  { name = "cmp_luasnip" },
		}, {
				--  { name = "buffer" },
				{ name = "path" },
			})
	})
end
cmp_setup()

local configs = require("nvim-treesitter.configs")
configs.setup({
	highlight = { enable = true },
	incremental_selection = { enable = true },
	indent = { enable = true },
})
