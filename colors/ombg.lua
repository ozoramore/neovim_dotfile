vim.cmd.hi('clear')
vim.g.colors_name = 'ombg'
local colors = {
	black     = { gui = '#101010', cli = 'Black' },
	red       = { gui = '#808080', cli = 'DarkGrey' },
	green     = { gui = '#707070', cli = 'DarkGrey' },
	yellow    = { gui = '#b0b0b0', cli = 'DarkGrey' },
	blue      = { gui = '#505050', cli = 'DarkGrey' },
	magenta   = { gui = '#a0a0a0', cli = 'LightGrey' },
	cyan      = { gui = '#b0b0b0', cli = 'LightGrey' },
	white     = { gui = '#d0d0d0', cli = 'LightGrey' },
	b_black   = { gui = '#555555', cli = 'DarkGrey' },
	b_red     = { gui = '#999999', cli = 'LightGrey' },
	b_green   = { gui = '#aaaaaa', cli = 'LightGrey' },
	b_yellow  = { gui = '#cccccc', cli = 'LightGrey' },
	b_blue    = { gui = '#666666', cli = 'DarkGrey' },
	b_magenta = { gui = '#bbbbbb', cli = 'LightGrey' },
	b_cyan    = { gui = '#eeeeee', cli = 'LightGrey' },
	b_white   = { gui = '#ffffff', cli = 'White' },

	tools     = { gui = '#666666', cli = 'DarkGrey' },
	comment   = { gui = '#aaaaaa', cli = 'LightGrey' },
	highlight = { gui = '#606060', cli = 'DarkYellow' },
	separator = { gui = '#eecc77', cli = 'DarkYellow' },
}

local hi = function(name, fg, bg, sp)
	local val = {}
	val.cterm = {}

	if sp then
		if sp.color then
			val.sp = sp.color.gui
		end
		if sp.attr then
			val[sp.attr] = true
			val.cterm[sp.attr] = true
		end
	end

	if fg then
		val.fg = fg.gui
		val.ctermfg = fg.cli
	end

	if bg then
		val.bg = bg.gui
		val.ctermbg = bg.cli
	end

	vim.api.nvim_set_hl(0, name, val)
end

local function link(name, target)
	local val = {}
	val.force = true
	val.link = target
	vim.api.nvim_set_hl(0, name, val)
end

-- General
hi('Normal', nil, nil)

hi('Conceal', colors.white, colors.b_black)
hi('Cursor', nil, nil)
hi('lCursor', nil, nil)
hi('DiffText', nil, colors.b_red, { attr = 'bold' })
hi('ErrorMsg', colors.b_white, colors.red)
hi('IncSearch', nil, nil, { attr = 'reverse' })
hi('ModeMsg', nil, nil, { attr = 'bold' })
hi('NonText', colors.b_black)
hi('PmenuSbar', nil, colors.b_black)
hi('StatusLine', nil, nil)
hi('StatusLineNC', nil, nil)
hi('TabLine', colors.b_black, nil)
hi('TabLineFill', nil, nil)
hi('TabLineSel', colors.b_white, nil, { attr = 'underline' })
hi('TermCursor', nil, nil, { attr = 'reverse' })
hi('WinBar', nil, nil, { attr = 'bold' })
hi('WildMenu', colors.black, colors.b_yellow)

hi('VertSplit', colors.separator, nil)
link('WinSeparator', 'VertSplit')
link('WinBarNC', 'WinBar')
link('EndOfBuffer', 'NonText')
link('LineNrAbove', 'LineNr')
link('LineNrBelow', 'LineNr')
link('QuickFixLine', 'Search')
link('CursorLineSign', 'SignColumn')
link('CursorLineFold', 'FoldColumn')
link('CurSearch', 'Search')
link('PmenuKind', 'Pmenu')
link('PmenuKindSel', 'PmenuSel')
link('PmenuExtra', 'Pmenu')
link('PmenuExtraSel', 'PmenuSel')
link('Substitute', 'Search')
link('Whitespace', 'NonText')
link('MsgSeparator', 'StatusLine')
link('NormalFloat', 'Pmenu')
link('FloatBorder', 'WinSeparator')
link('FloatTitle', 'Title')
link('FloatFooter', 'Title')

hi('FloatShadow', nil, nil, { blend = 80 })
hi('FloatShadowThrough', nil, nil, { blend = 100 })
hi('RedrawDebugNormal', nil, nil, { attr = 'reverse' })
hi('RedrawDebugClear', nil, colors.b_yellow)
hi('RedrawDebugComposed', nil, colors.green)
hi('RedrawDebugRecompose', nil, colors.red)
hi('Error', colors.b_white, colors.red)
hi('Todo', colors.black, colors.b_yellow)

link('String', 'Constant')
link('Character', 'Constant')
link('Number', 'Constant')
link('Boolean', 'Constant')
link('Float', 'Number')
link('Conditional', 'Statement')
link('Repeat', 'Statement')
link('Label', 'Statement')
link('Keyword', 'Statement')
link('Exception', 'Statement')
link('Include', 'PreProc')
link('Define', 'PreProc')
link('Macro', 'PreProc')
link('PreCondit', 'PreProc')
link('StorageClass', 'Type')
link('Structure', 'Type')
link('Typedef', 'Type')
link('Tag', 'Statement')
link('Delimiter', 'Special')
link('Debug', 'Special')

hi('DiagnosticError', colors.red, nil, { attr = 'bold' })
hi('DiagnosticWarn', colors.yellow, nil, { attr = 'bold' })
hi('DiagnosticInfo', colors.blue, nil, { attr = 'bold' })
hi('DiagnosticHint', colors.white, nil, { attr = 'bold' })
hi('DiagnosticOk', colors.green, nil, { attr = 'bold' })
hi('DiagnosticUnderlineError', nil, nil, { color = colors.b_red, attr = 'underline' })
hi('DiagnosticUnderlineWarn', nil, nil, { color = colors.yellow, attr = 'underline' })
hi('DiagnosticUnderlineInfo', nil, nil, { color = colors.b_blue, attr = 'underline' })
hi('DiagnosticUnderlineHint', nil, nil, { color = colors.white, attr = 'underline' })
hi('DiagnosticUnderlineOk', nil, nil, { color = colors.b_green, attr = 'underline' })
link('DiagnosticVirtualTextError', 'DiagnosticError')
link('DiagnosticVirtualTextWarn', 'DiagnosticWarn')
link('DiagnosticVirtualTextInfo', 'DiagnosticInfo')
link('DiagnosticVirtualTextHint', 'DiagnosticHint')
link('DiagnosticVirtualTextOk', 'DiagnosticOk')
link('DiagnosticFloatingError', 'DiagnosticError')
link('DiagnosticFloatingWarn', 'DiagnosticWarn')
link('DiagnosticFloatingInfo', 'DiagnosticInfo')
link('DiagnosticFloatingHint', 'DiagnosticHint')
link('DiagnosticFloatingOk', 'DiagnosticOk')
link('DiagnosticSignError', 'DiagnosticError')
link('DiagnosticSignWarn', 'DiagnosticWarn')
link('DiagnosticSignInfo', 'DiagnosticInfo')
link('DiagnosticSignHint', 'DiagnosticHint')
link('DiagnosticSignOk', 'DiagnosticOk')
hi('DiagnosticDeprecated', nil, nil, { color = colors.b_red, attr = 'strikethrough' })

link('DiagnosticUnnecessary', 'Comment')
link('LspInlayHint', 'NonText')
link('SnippetTabstop', 'Visual')

-- Text
link('@markup.raw', 'Constant')
link('@markup.link', 'Identifier')
link('@markup.heading', 'Title')
link('@markup.link.url', 'Underlined')
link('@markup.underline', 'Underlined')
link('@comment.todo', 'Todo')

-- Miscs
link('@comment', 'Comment')
link('@punctuation', 'Delimiter')

-- Constants
link('@constant', 'Constant')
link('@constant.builtin', 'SpecialChar')
link('@constant.macro', 'Define')
link('@keyword.directive', 'Define')
link('@string', 'String')
link('@string.escape', 'SpecialChar')
link('@string.special', 'SpecialChar')
link('@character', 'Character')
link('@character.special', 'SpecialChar')
link('@number', 'Number')
link('@boolean', 'Boolean')
link('@number.float', 'Float')

-- Functions
link('@function', 'Function')
link('@function.builtin', 'BuiltinFunc')
link('@function.macro', 'Macro')
link('@function.method', 'Function')
link('@variable.parameter', 'Identifier')
link('@variable.parameter.builtin', 'Special')
link('@variable.member', 'Identifier')
link('@property', 'Identifier')
link('@attribute', 'Macro')
link('@attribute.builtin', 'Macro')
link('@constructor', 'Special')

-- Keywords
link('@keyword.conditional', 'Conditional')
link('@keyword.repeat', 'Repeat')
link('@keyword.type', 'Structure')
link('@label', 'Label')
link('@operator', 'Operator')
link('@keyword', 'Keyword')
link('@keyword.exception', 'Exception')

link('@variable', 'Identifier')
link('@type', 'Type')
link('@type.builtin', 'BuiltinType')
link('@type.definition', 'Typedef')
link('@module', 'Identifier')
link('@keyword.import', 'Include')
link('@keyword.directive', 'PreProc')
link('@keyword.debug', 'Debug')
link('@tag', 'Tag')
link('@tag.builtin', 'Tag')

-- LSP semantic tokens
link('@lsp.type.class', 'Structure')
link('@lsp.type.comment', 'Comment')
link('@lsp.type.decorator', 'Function')
link('@lsp.type.enum', 'Structure')
link('@lsp.type.enumMember', 'Constant')
link('@lsp.type.function', 'Function')
link('@lsp.type.interface', 'Structure')
link('@lsp.type.macro', 'Macro')
link('@lsp.type.method', 'Function')
link('@lsp.type.namespace', 'Structure')
link('@lsp.type.parameter', 'Identifier')
link('@lsp.type.property', 'Identifier')
link('@lsp.type.struct', 'Structure')
link('@lsp.type.type', 'Type')
link('@lsp.type.typeParameter', 'TypeDef')
link('@lsp.type.variable', 'Identifier')

-- Default colors
hi('ColorColumn', nil, colors.tools)
hi('CursorColumn', nil, nil)
hi('CursorLine', nil, nil)
hi('CursorLineNr', colors.highlight, nil, { color = colors.highlight, attr = 'underline' })
hi('DiffAdd', colors.green, colors.black)
hi('DiffChange', nil, colors.magenta)
hi('DiffDelete', colors.red, colors.black)
hi('Directory', colors.b_cyan, nil)
hi('FoldColumn', colors.tools, nil)
hi('Folded', colors.tools, nil, { attr = 'underline' })
hi('LineNr', colors.tools, nil)
hi('MatchParen', nil, nil, { color = colors.highlight, attr = 'underdouble' })
hi('MoreMsg', colors.b_green, nil, { attr = 'bold' })
hi('Pmenu', colors.b_white, colors.black)
hi('PmenuSel', colors.b_white, colors.blue)
hi('PmenuThumb', nil, colors.b_white)
hi('Question', colors.b_green, nil, { attr = 'italic' })
hi('Search', colors.highlight, colors.black, { attr = 'reverse' })
hi('SignColumn', colors.b_cyan, nil, { attr = 'bold' })
hi('SpecialKey', colors.b_blue, nil)
hi('SpellBad', nil, colors.b_red, { color = colors.b_red, attr = 'undercurl' })
hi('SpellCap', nil, colors.b_blue, { color = colors.b_blue, attr = 'undercurl' })
hi('SpellLocal', nil, colors.b_cyan, { color = colors.b_cyan, attr = 'undercurl' })
hi('SpellRare', nil, colors.b_magenta, { color = colors.b_magenta, attr = 'undercurl' })
hi('Title', colors.b_magenta, nil, { attr = 'bold' })
hi('Visual', nil, nil, { attr = 'reverse' })
hi('WarningMsg', colors.red, nil)
hi('Comment', colors.comment, nil, { attr = 'italic' })
hi('Constant', colors.b_green, nil)
hi('Special', colors.white, nil)
hi('SpecialChar', colors.yellow, nil, { attr = 'italic' })
hi('Function', colors.b_blue, nil)
hi('BuiltinFunc', colors.b_blue, nil, { attr = 'italic' })
hi('Identifier', colors.b_cyan, nil)
hi('Statement', colors.b_yellow, nil)
hi('Operator', colors.yellow, nil)
hi('PreProc', colors.magenta, nil)
hi('Type', colors.cyan, nil)
hi('BuiltinType', colors.cyan, nil, { attr = 'italic' })
hi('Underlined', nil, nil, { attr = 'underline' })
hi('Ignore', colors.black, nil)

hi('MiniStatuslineModeNormal', colors.black, colors.b_blue)
hi('MiniStatuslineModeInsert', colors.black, colors.b_green)
hi('MiniStatuslineModeCommand', colors.black, colors.b_red)
hi('MiniStatuslineModeVisual', colors.black, colors.magenta)
hi('MiniStatuslineModeReplace', colors.black, colors.yellow)
hi('MiniStatuslineModeOther', nil, colors.b_black)

hi('OMStatuslineModeNormal', nil, nil, { color = colors.b_blue, attr = 'underline' })
hi('OMStatuslineModeInsert', nil, nil, { color = colors.b_green, attr = 'underline' })
hi('OMStatuslineModeCommand', nil, nil, { color = colors.b_red, attr = 'underline' })
hi('OMStatuslineModeVisual', nil, nil, { color = colors.magenta, attr = 'underline' })
hi('OMStatuslineModeReplace', nil, nil, { color = colors.yellow, attr = 'underline' })
hi('OMStatuslineModeOther', nil, nil, { color = colors.b_black, attr = 'underline' })

hi('GitSignsAdd', colors.green, nil)
hi('GitSignsChange', colors.blue, nil)
hi('GitSignsDelete', colors.red, nil)
hi('GitSignsUntracked', colors.white, nil)

hi('LineNrGroup1', nil, nil, { color = colors.highlight, attr = 'underdotted' })
hi('LineNrGroup2', nil, nil, { color = colors.highlight, attr = 'underdashed' })
hi('LineNrGroup3', nil, nil, { color = colors.highlight, attr = 'underline' })
hi('LineNrGroup4', nil, nil, { color = colors.b_cyan, attr = 'underdashed' })
hi('LineNrGroup5', colors.b_cyan, nil, { color = colors.b_cyan, attr = 'underdashed' })
hi('LineNrInterval', nil, nil, { color = colors.cyan, attr = 'underline' })
