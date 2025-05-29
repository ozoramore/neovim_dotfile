local M = {}

local load = require('plugin.loader').load

local function setup_lsp(lsp)
	if lsp.config then
		vim.lsp.config(lsp.name, lsp.config)
	end
	vim.lsp.enable(lsp.name)
end

local function setup_completion(args)
	local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	if client:supports_method('textDocument/completion') then
		vim.lsp.completion.enable(true, client.id, 0, { autotrigger = true })
	end
end

local lsps = {
	{ name = 'bashls' },
	{ name = 'lua_ls' },
	{ name = 'ts_ls' },
	{ name = 'lemminx' },
	{ name = 'solargraph' },
	{ name = 'clangd',        config = { cmd = { 'clangd', '--header-insertion=never', '--clang-tidy', '--enable-config' } } },
	{ name = 'rust_analyzer', config = { cmd = { 'rustup', 'run', 'stable', 'rust_analyzer' } } }
}

local function setup()
	require('lspconfig')
	for _, lsp in ipairs(lsps) do setup_lsp(lsp) end
	vim.api.nvim_create_autocmd({ 'LspAttach' }, { callback = setup_completion })
end

function M.setup()
	if vim.fn.has('unix') ~= 1 then return end
	load('neovim/nvim-lspconfig', setup)
end

local function has_format()
	local lsp_client = vim.lsp.get_clients({ method = 'textDocument/formatting' })
	return #lsp_client ~= 0
end

function M.format()
	local result = has_format()
	if result then vim.lsp.buf.format() end
	return result
end

return M
