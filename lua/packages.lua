
local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath('data') .. '/pckr/pckr.nvim'

	if not vim.uv.fs_stat(pckr_path) then
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/lewis6991/pckr.nvim',
			pckr_path
		})
	end
	vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
	-- Post-install/update hook with neovim command
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'neovim/nvim-lspconfig' },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'nvim-lualine/lualine.nvim' },
	{ 'gmartsenkov/root.nvim' },
	{ 'h-hg/fcitx.nvim' },
	{ 'rhysd/vim-clang-format' },
	{ 'folke/styler.nvim' },
}
