local function lsp_formatter()
	vim.lsp.buf.format({ async = true })
end

local function native_formatter()
	local pos = vim.fn.getpos('.')
	vim.cmd.normal('gg=G')
	vim.fn.setpos('.', pos)
end

local function formatter()
	local lsp_client = vim.lsp.get_clients({ bufnr = 0 })[1]
	if (lsp_client and lsp_client:supports_method('textDocument/formatting')) then
		lsp_formatter()
	else
		native_formatter()
	end
end

vim.api.nvim_create_user_command('Format', formatter, {})

require('option')
require('keymap')
require('filetype')
require('plugin')
