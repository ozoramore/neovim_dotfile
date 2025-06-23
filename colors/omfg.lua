vim.cmd.hi('clear')
vim.g.colors_name = 'omfg'
local colors = {
	black     = '#17181a',
	red       = '#d95136',
	green     = '#51966c',
	yellow    = '#d9a336',
	blue      = '#366cd9',
	magenta   = '#9589d9',
	cyan      = '#36bed9',
	white     = '#dcdfe4',
	b_black   = '#5c5c6e',
	b_red     = '#ff9580',
	b_green   = '#84cf98',
	b_yellow  = '#ffd480',
	b_blue    = '#80aaff',
	b_magenta = '#d273e6',
	b_cyan    = '#80eaff',
	b_white   = '#ffffff',

	tools     = '#606066',
	comment   = '#a4bfb6',
	highlight = '#eecc77',
	separator = '#eecc77',
}

local hi = function(name, fg, bg, val)
	val = val or {}
	val.force = true
	val.cterm = val.cterm or {}
	val.fg = fg
	val.bg = bg
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
hi('DiffText', nil, colors.b_red, { bold = true })
hi('ErrorMsg', colors.b_white, colors.red)
hi('IncSearch', nil, nil, { reverse = true })
hi('ModeMsg', nil, nil, { bold = true })
hi('NonText', colors.b_black, nil)
hi('PmenuSbar', nil, colors.b_black)
hi('StatusLine', nil, colors.black)
hi('StatusLineNC', nil, nil)
hi('TabLine', colors.b_black, nil)
hi('TabLineFill', nil, nil)
hi('TabLineSel', colors.b_white, nil, { underline = true })
hi('TermCursor', nil, nil, { reverse = true })
hi('WinBar', nil, nil, { bold = true })
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
hi('RedrawDebugNormal', nil, nil, { reverse = true })
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

hi('DiagnosticError', colors.red, nil, { bold = true })
hi('DiagnosticWarn', colors.yellow, nil, { bold = true })
hi('DiagnosticInfo', colors.blue, nil, { bold = true })
hi('DiagnosticHint', colors.white, nil, { bold = true })
hi('DiagnosticOk', colors.green, nil, { bold = true })
hi('DiagnosticUnderlineError', nil, nil, { sp = colors.b_red, underline = true })
hi('DiagnosticUnderlineWarn', nil, nil, { sp = colors.yellow, underline = true })
hi('DiagnosticUnderlineInfo', nil, nil, { sp = colors.b_blue, underline = true })
hi('DiagnosticUnderlineHint', nil, nil, { sp = colors.white, underline = true })
hi('DiagnosticUnderlineOk', nil, nil, { sp = colors.b_green, underline = true })
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
hi('DiagnosticDeprecated', nil, nil, { sp = colors.b_red, strikethrough = true })

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
hi('CursorLineNr', colors.highlight, nil, { sp = colors.highlight, underline = true })
hi('DiffAdd', colors.green, colors.black)
hi('DiffChange', nil, colors.magenta)
hi('DiffDelete', colors.red, colors.black)
hi('Directory', colors.b_cyan, nil)
hi('FoldColumn', colors.tools, nil)
hi('Folded', colors.tools, nil, { underline = true })
hi('LineNr', colors.tools, nil)
hi('MatchParen', nil, nil, { sp = colors.highlight, underdouble = true })
hi('MoreMsg', colors.b_green, nil, { bold = true })
hi('Pmenu', colors.b_white, colors.black)
hi('PmenuSel', colors.b_white, colors.blue)
hi('PmenuThumb', nil, colors.b_white)
hi('Question', colors.b_green, nil, { italic = true })
hi('Search', colors.highlight, colors.black, { reverse = true })
hi('SignColumn', colors.b_cyan, nil, { bold = true })
hi('SpecialKey', colors.b_blue, nil)
hi('SpellBad', nil, colors.b_red, { sp = colors.b_red, undercurl = true })
hi('SpellCap', nil, colors.b_blue, { sp = colors.b_blue, undercurl = true })
hi('SpellLocal', nil, colors.b_cyan, { sp = colors.b_cyan, undercurl = true })
hi('SpellRare', nil, colors.b_magenta, { sp = colors.b_magenta, undercurl = true })
hi('Title', colors.b_magenta, nil, { bold = true })
hi('Visual', nil, nil, { reverse = true })
hi('WarningMsg', colors.red, nil)
hi('Comment', colors.comment, nil, { italic = true })
hi('Constant', colors.b_green, nil)
hi('Special', colors.white, nil)
hi('SpecialChar', colors.yellow, nil, { italic = true })
hi('Function', colors.b_blue, nil)
hi('BuiltinFunc', colors.b_blue, nil, { italic = true })
hi('Identifier', colors.b_cyan, nil)
hi('Statement', colors.b_yellow, nil)
hi('Operator', colors.yellow, nil)
hi('PreProc', colors.magenta, nil)
hi('Type', colors.cyan, nil)
hi('BuiltinType', colors.cyan, nil, { italic = true })
hi('Underlined', nil, nil, { underline = true })
hi('Ignore', colors.black, nil)

hi('MiniStatuslineModeNormal', colors.black, colors.b_blue)
hi('MiniStatuslineModeInsert', colors.black, colors.b_green)
hi('MiniStatuslineModeCommand', colors.black, colors.b_red)
hi('MiniStatuslineModeVisual', colors.black, colors.magenta)
hi('MiniStatuslineModeReplace', colors.black, colors.yellow)
hi('MiniStatuslineModeOther', nil, colors.b_black)

hi('GitSignsAdd', colors.green, nil)
hi('GitSignsChange', colors.blue, nil)
hi('GitSignsDelete', colors.red, nil)
hi('GitSignsUntracked', colors.white, nil)

hi('LineNrGroup1', nil, nil, { sp = colors.highlight, underdotted = true })
hi('LineNrGroup2', nil, nil, { sp = colors.highlight, underdashed = true })
hi('LineNrGroup3', nil, nil, { sp = colors.highlight, underline = true })
hi('LineNrGroup4', nil, nil, { sp = colors.b_cyan, underdashed = true })
hi('LineNrGroup5', colors.b_cyan, nil, { sp = colors.b_cyan, underdashed = true })
hi('LineNrInterval', nil, nil, { sp = colors.cyan, underline = true })
