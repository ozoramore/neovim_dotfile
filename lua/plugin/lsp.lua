local M = {}

local function setup_completion(args)
	local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	if client:supports_method('textDocument/completion') then
		vim.lsp.completion.enable(true, client.id, args.bufnr)
	end
end

local conf = {
	clangd = {
		cmd = { 'clangd', '--header-insertion=never', '--clang-tidy', '--enable-config' },
		capabilities = { offsetEncoding = {} } -- Error -32602 対策
	},
	rust_analyzer = {
		cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' }
	},
}

local lsps = {
	{ name = 'bashls' },
	{ name = 'lua_ls' },
	{ name = 'ts_ls' },
	{ name = 'lemminx' },
	{ name = 'solargraph' },
	{ name = 'clangd',        config = conf.clangd },
	{ name = 'rust_analyzer', config = conf.rust_analyzer },
	{ name = 'zls' },
	{ name = 'html' },
	{ name = 'cssls' },
	{ name = 'jsonls' },
	{ name = 'pylsp' },
	{ name = 'cmake' },
}

function M.setup()
	vim.api.nvim_create_autocmd({ 'LspAttach' }, { callback = setup_completion })
	require('lspconfig')
	for _, lsp in ipairs(lsps) do
		if lsp.config then vim.lsp.config(lsp.name, lsp.config) end
		vim.lsp.enable(lsp.name)
	end
end

return M
