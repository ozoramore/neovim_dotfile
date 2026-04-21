local M = {}

local url = {
	mini_deps = 'https://github.com/nvim-mini/mini.deps',           -- プラグインマネージャ
	mini_statusline = 'https://github.com/nvim-mini/mini.statusline', -- statuslineの装飾
	mini_completion = 'https://github.com/nvim-mini/mini.completion', -- タブ補完の対応
	mini_snippets = 'https://github.com/nvim-mini/mini.snippets',   -- タブ補完で出てくる候補に対応
	unicode_search = 'https://git.sr.ht/~xigoi/nvim-unicode-search', -- Unicode文字を検索、カーソル位置のUnicode文字を探す。
	mpc = 'https://github.com/ozoramore/nvimpc.lua',                -- Music Player Daemonの制御
	styler = 'https://github.com/folke/styler.nvim',                -- バッファごとに色分け
	gitsigns = 'https://github.com/lewis6991/gitsigns.nvim',        -- statuscolumnにgitの状態を表示
	statuscol = 'https://github.com/luukvbaal/statuscol.nvim',      -- statuscolumnの装飾
	lnum_color = 'https://github.com/ozoramore/lnum_color.lua',     -- 行番号の装飾
	dap = 'https://github.com/mfussenegger/nvim-dap',               -- DebugAdapterProtocolの対応
	dap_view = 'https://github.com/igorlfs/nvim-dap-view',          -- DAPのビジュアライズ
	treesitter = 'https://github.com/nvim-treesitter/nvim-treesitter', -- TreeSitterに対応
	lspconfig = 'https://github.com/neovim/nvim-lspconfig',         -- LanguageServerProtocolに対応
	tig = 'https://github.com/ozoramore/tig.nvim'                   -- Tig(git用TUI)を内部から呼び出す
}

M.setup = function()
	--- 各種プラグイン設定
	require('plugin.mini_deps').setup(url.mini_deps)
	local load = require('plugin.mini_deps').load

	-- mini.nvim
	load({ source = url.mini_statusline }, require('plugin.mini_statusline').setup, true)
	load({ source = url.mini_completion }, require('plugin.mini_completion').setup)
	load({ source = url.mini_snippets }, require('plugin.mini_snippets').setup)

	-- unicode検索
	load({ source = url.unicode_search }, require('plugin.unicode').setup)

	-- neovimでmpdを制御する自作プラグイン
	load({ source = url.mpc }, require('plugin.mpc').setup, true)

	-- 外観
	load({ source = url.styler }, require('plugin.styler').setup, true)
	load({ source = url.gitsigns }, require('plugin.gitsigns').setup, true)
	load({ source = url.statuscol }, require('plugin.statuscol').setup)
	load({ source = url.lnum_color }, require('plugin.lnum_color').setup)

	-- DAP/treesitter/lspなど、外部コマンドに依存する系の設定
	load({ source = url.dap_view, depends = { url.dap } }, require('plugin.dap').setup, true)
	load({ source = url.treesitter }, require('plugin.treesitter').setup, true)
	load({ source = url.lspconfig }, require('plugin.lsp').setup, true)
	load({ source = url.tig }, require('plugin.tig').setup, true)
end

return M
