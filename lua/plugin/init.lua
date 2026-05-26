local M = {}

local url = {
	'https://github.com/nvim-mini/mini.statusline',    -- statuslineの装飾
	'https://github.com/nvim-mini/mini.completion',    -- タブ補完の対応
	'https://github.com/nvim-mini/mini.snippets',      -- タブ補完で出てくる候補に対応
	'https://git.sr.ht/~xigoi/nvim-unicode-search',    -- Unicode文字を検索、カーソル位置のUnicode文字を探す。
	'https://github.com/ozoramore/nvimpc.lua',         -- Music Player Daemonの制御
	'https://github.com/folke/styler.nvim',            -- バッファごとに色分け
	'https://github.com/lewis6991/gitsigns.nvim',      -- statuscolumnにgitの状態を表示
	'https://github.com/luukvbaal/statuscol.nvim',     -- statuscolumnの装飾
	'https://github.com/ozoramore/lnum_color.lua',     -- 行番号の装飾
	'https://github.com/mfussenegger/nvim-dap',        -- DebugAdapterProtocolの対応
	'https://github.com/igorlfs/nvim-dap-view',        -- DAPのビジュアライズ
	'https://github.com/nvim-treesitter/nvim-treesitter', -- TreeSitterに対応
	'https://github.com/neovim/nvim-lspconfig',        -- LanguageServerProtocolに対応
	'https://github.com/ozoramore/tig.nvim'            -- Tig(git用TUI)を内部から呼び出す
}

M.setup = function()
	--- 各種プラグイン設定
	vim.pack.add(url)
	local load = require('util.pack').load

	-- mini.nvim
	load(require('plugin.mini_statusline').setup, true)
	load(require('plugin.mini_completion').setup, false)
	load(require('plugin.mini_snippets').setup, false)

	-- unicode検索
	load(require('plugin.unicode').setup, false)

	-- neovimでmpdを制御する自作プラグイン
	load(require('plugin.mpc').setup, true)

	-- 外観
	load(require('plugin.styler').setup, true)
	load(require('plugin.gitsigns').setup, true)
	load(require('plugin.statuscol').setup, true)
	load(require('plugin.lnum_color').setup, true)

	-- DAP/treesitter/lspなど、外部コマンドに依存する系の設定
	load(require('plugin.dap').setup, true)
	load(require('plugin.treesitter').setup, true)
	load(require('plugin.lsp').setup, true)
	load(require('plugin.tig').setup, true)
end

return M
