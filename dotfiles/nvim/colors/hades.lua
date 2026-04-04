-- hades.lua
-- Neovim colorscheme: Hades
-- God of the underworld, shadows, and subterranean riches.
-- Deep asphalt blacks, bone whites, pale gold veins, sulfur accents,
-- and cold violet for the river Styx.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "hades"
vim.o.background = "dark"

local c = {
	-- Foundations
	void         = "#0a0a0f", -- the pit: deepest background
	abyss        = "#0f0f17", -- bg normal
	cavern       = "#171722", -- bg slightly raised (splits, floats)
	stone        = "#21212e", -- bg visual / selection
	shadow       = "#2c2c3d", -- bg subtle highlight / cursorline
	slate        = "#3d3d52", -- ui borders, column separators
	ash          = "#5a5a74", -- comments, disabled
	bone         = "#b8b0a0", -- fg muted / secondary text
	shroud       = "#d4cfc6", -- fg normal
	specter      = "#ede8e0", -- fg bright / headings

	-- The riches of the earth (Hades was lord of all precious metals)
	gold_vein    = "#c8a96e", -- keywords / wealth
	pale_gold    = "#e2c98a", -- functions / refined gold
	amber_ore    = "#d4894a", -- numbers / raw ore

	-- Bone and ivory
	ivory        = "#e8e0d0", -- strings (pale, carved)
	ivory_dim    = "#c4bdb0", -- string escape sequences

	-- Sulfur (volcanic underworld)
	sulfur       = "#b8c44a", -- booleans / warnings turned sickly yellow-green

	-- River Styx (cold violet-blue, liminal)
	styx         = "#7b8cde", -- types / the river itself
	styx_deep    = "#5a6ab8", -- type qualifiers / deeper current

	-- Asphodel (pale lavender for the meadows of the dead)
	asphodel     = "#9e93c8", -- operators / pale violet
	asphodel_dim = "#6e6594", -- punctuation

	-- Cerberus (red, not fire — dried blood, warning)
	cerberus     = "#c0524a", -- errors / the guard
	cerberus_dim = "#8a3a34", -- error underline bg

	-- Persephone (a hint of living green, cold and far away)
	persephone   = "#7aab82", -- constructors / she is still alive

	-- Charon (cool gray, the ferryman)
	charon       = "#6a7a8a", -- line numbers, inactive
	charon_hi    = "#8a9aaa", -- line number current

	none         = "NONE",
}

local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- ─── Editor chrome ────────────────────────────────────────────────────────────
hi("Normal", { fg = c.shroud, bg = c.abyss })
hi("NormalFloat", { fg = c.shroud, bg = c.cavern })
hi("NormalNC", { fg = c.bone, bg = c.abyss })
hi("FloatBorder", { fg = c.slate, bg = c.cavern })
hi("FloatTitle", { fg = c.gold_vein, bg = c.cavern })

hi("Cursor", { fg = c.void, bg = c.pale_gold })
hi("CursorLine", { bg = c.shadow })
hi("CursorLineNr", { fg = c.charon_hi, bg = c.shadow, bold = true })
hi("CursorColumn", { bg = c.shadow })
hi("ColorColumn", { bg = c.cavern })

hi("LineNr", { fg = c.charon })
hi("SignColumn", { fg = c.slate, bg = c.abyss })
hi("FoldColumn", { fg = c.slate, bg = c.abyss })
hi("Folded", { fg = c.ash, bg = c.cavern, italic = true })

hi("StatusLine", { fg = c.bone, bg = c.void })
hi("StatusLineNC", { fg = c.ash, bg = c.void })
hi("WinBar", { fg = c.gold_vein, bg = c.abyss })
hi("WinBarNC", { fg = c.ash, bg = c.abyss })
hi("WinSeparator", { fg = c.slate, bg = c.none })

hi("TabLine", { fg = c.ash, bg = c.void })
hi("TabLineSel", { fg = c.pale_gold, bg = c.abyss, bold = true })
hi("TabLineFill", { bg = c.void })

hi("Pmenu", { fg = c.bone, bg = c.cavern })
hi("PmenuSel", { fg = c.specter, bg = c.shadow, bold = true })
hi("PmenuSbar", { bg = c.cavern })
hi("PmenuThumb", { bg = c.slate })
hi("PmenuKind", { fg = c.styx, bg = c.cavern })
hi("PmenuKindSel", { fg = c.styx, bg = c.shadow })
hi("PmenuExtra", { fg = c.ash, bg = c.cavern })
hi("PmenuExtraSel", { fg = c.ash, bg = c.shadow })

hi("Visual", { bg = c.stone })
hi("VisualNOS", { bg = c.stone })
hi("Search", { fg = c.void, bg = c.pale_gold })
hi("IncSearch", { fg = c.void, bg = c.amber_ore })
hi("CurSearch", { fg = c.void, bg = c.gold_vein })
hi("Substitute", { fg = c.void, bg = c.sulfur })

hi("MatchParen", { fg = c.pale_gold, bg = c.stone, bold = true })
hi("NonText", { fg = c.slate })
hi("Whitespace", { fg = c.slate })
hi("SpecialKey", { fg = c.slate })
hi("EndOfBuffer", { fg = c.void })

hi("Directory", { fg = c.pale_gold, bold = true })
hi("Title", { fg = c.gold_vein, bold = true })
hi("Question", { fg = c.persephone })
hi("MoreMsg", { fg = c.persephone })
hi("ModeMsg", { fg = c.bone })
hi("ErrorMsg", { fg = c.cerberus })
hi("WarningMsg", { fg = c.sulfur })

hi("SpellBad", { undercurl = true, sp = c.cerberus })
hi("SpellCap", { undercurl = true, sp = c.styx })
hi("SpellRare", { undercurl = true, sp = c.asphodel })
hi("SpellLocal", { undercurl = true, sp = c.sulfur })

hi("DiffAdd", { fg = c.persephone, bg = "#1a2e1e" })
hi("DiffChange", { fg = c.styx, bg = "#191f35" })
hi("DiffDelete", { fg = c.cerberus, bg = "#2a1414" })
hi("DiffText", { fg = c.specter, bg = "#1e2a45", bold = true })
hi("Added", { fg = c.persephone })
hi("Changed", { fg = c.styx })
hi("Removed", { fg = c.cerberus })

-- ─── Syntax ────────────────────────────────────────────────────────────────────
hi("Comment", { fg = c.ash, italic = true })
hi("Constant", { fg = c.ivory })
hi("String", { fg = c.ivory })
hi("Character", { fg = c.ivory_dim })
hi("Number", { fg = c.amber_ore })
hi("Float", { fg = c.amber_ore })
hi("Boolean", { fg = c.sulfur, bold = true })

hi("Identifier", { fg = c.shroud })
hi("Function", { fg = c.pale_gold })

hi("Statement", { fg = c.gold_vein, bold = true })
hi("Conditional", { fg = c.gold_vein, bold = true })
hi("Repeat", { fg = c.gold_vein, bold = true })
hi("Label", { fg = c.gold_vein })
hi("Operator", { fg = c.asphodel })
hi("Keyword", { fg = c.gold_vein, bold = true })
hi("Exception", { fg = c.cerberus, bold = true })

hi("PreProc", { fg = c.styx_deep })
hi("Include", { fg = c.styx_deep })
hi("Define", { fg = c.styx_deep })
hi("Macro", { fg = c.styx })
hi("PreCondit", { fg = c.styx_deep })

hi("Type", { fg = c.styx })
hi("StorageClass", { fg = c.styx, bold = true })
hi("Structure", { fg = c.styx, bold = true })
hi("Typedef", { fg = c.styx })

hi("Special", { fg = c.asphodel })
hi("SpecialChar", { fg = c.ivory_dim })
hi("Tag", { fg = c.pale_gold })
hi("Delimiter", { fg = c.asphodel_dim })
hi("SpecialComment", { fg = c.ash, bold = true, italic = true })
hi("Debug", { fg = c.cerberus })

hi("Underlined", { underline = true })
hi("Ignore", { fg = c.slate })
hi("Error", { fg = c.cerberus, bold = true })
hi("Todo", { fg = c.void, bg = c.gold_vein, bold = true })

-- ─── Treesitter ────────────────────────────────────────────────────────────────
-- Variables
hi("@variable", { fg = c.shroud })
hi("@variable.builtin", { fg = c.asphodel, italic = true })
hi("@variable.parameter", { fg = c.bone, italic = true })
hi("@variable.member", { fg = c.persephone })        -- struct fields / object props

-- Functions
hi("@function", { fg = c.pale_gold })
hi("@function.builtin", { fg = c.amber_ore })
hi("@function.call", { fg = c.pale_gold })
hi("@function.macro", { fg = c.styx })
hi("@function.method", { fg = c.pale_gold })
hi("@function.method.call", { fg = c.pale_gold })

-- Constructors
hi("@constructor", { fg = c.persephone, bold = true })

-- Keywords
hi("@keyword", { fg = c.gold_vein, bold = true })
hi("@keyword.function", { fg = c.gold_vein, bold = true })
hi("@keyword.operator", { fg = c.asphodel })
hi("@keyword.return", { fg = c.gold_vein, bold = true, italic = true })
hi("@keyword.import", { fg = c.styx_deep })
hi("@keyword.modifier", { fg = c.styx, bold = true })
hi("@keyword.exception", { fg = c.cerberus, bold = true })

-- Types
hi("@type", { fg = c.styx })
hi("@type.builtin", { fg = c.styx_deep, bold = true })
hi("@type.definition", { fg = c.styx, bold = true })
hi("@type.qualifier", { fg = c.styx_deep })

-- Strings
hi("@string", { fg = c.ivory })
hi("@string.escape", { fg = c.ivory_dim })
hi("@string.special", { fg = c.ivory_dim })
hi("@string.regexp", { fg = c.amber_ore })

-- Literals
hi("@number", { fg = c.amber_ore })
hi("@number.float", { fg = c.amber_ore })
hi("@boolean", { fg = c.sulfur, bold = true })
hi("@character", { fg = c.ivory_dim })

-- Punctuation
hi("@punctuation.delimiter", { fg = c.asphodel_dim })
hi("@punctuation.bracket", { fg = c.asphodel })
hi("@punctuation.special", { fg = c.asphodel })

-- Comments
hi("@comment", { fg = c.ash, italic = true })
hi("@comment.documentation", { fg = c.charon_hi, italic = true })

-- Operators
hi("@operator", { fg = c.asphodel })

-- Attributes / Decorators
hi("@attribute", { fg = c.styx, italic = true })
hi("@attribute.builtin", { fg = c.styx_deep, italic = true })

-- Misc
hi("@module", { fg = c.shroud, bold = true })
hi("@label", { fg = c.gold_vein })
hi("@tag", { fg = c.pale_gold })
hi("@tag.attribute", { fg = c.styx, italic = true })
hi("@tag.delimiter", { fg = c.asphodel_dim })
hi("@namespace", { fg = c.shroud, bold = true })

-- Markup (markdown etc.)
hi("@markup.heading", { fg = c.gold_vein, bold = true })
hi("@markup.raw", { fg = c.bone, bg = c.cavern })
hi("@markup.link", { fg = c.styx, underline = true })
hi("@markup.link.label", { fg = c.pale_gold })
hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.list", { fg = c.asphodel })
hi("@markup.list.checked", { fg = c.persephone })
hi("@markup.list.unchecked", { fg = c.ash })

-- ─── LSP semantic tokens ───────────────────────────────────────────────────────
hi("@lsp.type.class", { fg = c.styx, bold = true })
hi("@lsp.type.decorator", { fg = c.styx, italic = true })
hi("@lsp.type.enum", { fg = c.styx })
hi("@lsp.type.enumMember", { fg = c.amber_ore })
hi("@lsp.type.function", { fg = c.pale_gold })
hi("@lsp.type.interface", { fg = c.styx, italic = true })
hi("@lsp.type.macro", { fg = c.styx })
hi("@lsp.type.method", { fg = c.pale_gold })
hi("@lsp.type.namespace", { fg = c.shroud, bold = true })
hi("@lsp.type.parameter", { fg = c.bone, italic = true })
hi("@lsp.type.property", { fg = c.persephone })
hi("@lsp.type.struct", { fg = c.styx, bold = true })
hi("@lsp.type.type", { fg = c.styx })
hi("@lsp.type.typeParameter", { fg = c.styx, italic = true })
hi("@lsp.type.variable", { fg = c.shroud })

-- ─── LSP diagnostics ──────────────────────────────────────────────────────────
hi("DiagnosticError", { fg = c.cerberus })
hi("DiagnosticWarn", { fg = c.sulfur })
hi("DiagnosticInfo", { fg = c.styx })
hi("DiagnosticHint", { fg = c.asphodel })
hi("DiagnosticOk", { fg = c.persephone })

hi("DiagnosticUnderlineError", { undercurl = true, sp = c.cerberus })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.sulfur })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.styx })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.asphodel })

hi("DiagnosticVirtualTextError", { fg = c.cerberus, bg = c.cerberus_dim, italic = true })
hi("DiagnosticVirtualTextWarn", { fg = c.sulfur, bg = "#252510", italic = true })
hi("DiagnosticVirtualTextInfo", { fg = c.styx, bg = "#141630", italic = true })
hi("DiagnosticVirtualTextHint", { fg = c.asphodel, bg = "#1a1830", italic = true })

hi("DiagnosticSignError", { fg = c.cerberus, bg = c.abyss })
hi("DiagnosticSignWarn", { fg = c.sulfur, bg = c.abyss })
hi("DiagnosticSignInfo", { fg = c.styx, bg = c.abyss })
hi("DiagnosticSignHint", { fg = c.asphodel, bg = c.abyss })

-- ─── LSP references ───────────────────────────────────────────────────────────
hi("LspReferenceText", { bg = c.shadow })
hi("LspReferenceRead", { bg = c.shadow })
hi("LspReferenceWrite", { bg = c.shadow, underline = true })
hi("LspInlayHint", { fg = c.ash, bg = c.cavern, italic = true })
hi("LspCodeLens", { fg = c.ash, italic = true })
hi("LspSignatureActiveParameter", { fg = c.pale_gold, bold = true })

-- ─── Telescope ────────────────────────────────────────────────────────────────
hi("TelescopeNormal", { fg = c.shroud, bg = c.cavern })
hi("TelescopeBorder", { fg = c.slate, bg = c.cavern })
hi("TelescopeTitle", { fg = c.gold_vein, bg = c.cavern, bold = true })
hi("TelescopePromptNormal", { fg = c.specter, bg = c.shadow })
hi("TelescopePromptBorder", { fg = c.slate, bg = c.shadow })
hi("TelescopePromptTitle", { fg = c.pale_gold, bg = c.shadow })
hi("TelescopePromptPrefix", { fg = c.gold_vein, bg = c.shadow })
hi("TelescopeSelection", { fg = c.specter, bg = c.shadow, bold = true })
hi("TelescopeSelectionCaret", { fg = c.gold_vein, bg = c.shadow })
hi("TelescopeMatching", { fg = c.pale_gold, bold = true })
hi("TelescopeResultsTitle", { fg = c.ash, bg = c.cavern })
hi("TelescopePreviewTitle", { fg = c.persephone, bg = c.cavern })
hi("TelescopePreviewBorder", { fg = c.slate, bg = c.cavern })

-- ─── nvim-tree ────────────────────────────────────────────────────────────────
hi("NvimTreeNormal", { fg = c.bone, bg = c.void })
hi("NvimTreeNormalNC", { fg = c.bone, bg = c.void })
hi("NvimTreeRootFolder", { fg = c.gold_vein, bold = true })
hi("NvimTreeFolderName", { fg = c.pale_gold })
hi("NvimTreeOpenedFolderName", { fg = c.pale_gold, bold = true })
hi("NvimTreeEmptyFolderName", { fg = c.ash })
hi("NvimTreeFolderIcon", { fg = c.gold_vein })
hi("NvimTreeFileName", { fg = c.bone })
hi("NvimTreeOpenedFile", { fg = c.shroud, bold = true })
hi("NvimTreeModifiedFile", { fg = c.amber_ore })
hi("NvimTreeGitDirty", { fg = c.amber_ore })
hi("NvimTreeGitStaged", { fg = c.persephone })
hi("NvimTreeGitNew", { fg = c.persephone })
hi("NvimTreeGitDeleted", { fg = c.cerberus })
hi("NvimTreeGitIgnored", { fg = c.ash })
hi("NvimTreeIndentMarker", { fg = c.slate })
hi("NvimTreeSymlink", { fg = c.styx })
hi("NvimTreeSpecialFile", { fg = c.asphodel })
hi("NvimTreeWinSeparator", { fg = c.slate, bg = c.void })

-- ─── gitsigns ─────────────────────────────────────────────────────────────────
hi("GitSignsAdd", { fg = c.persephone, bg = c.abyss })
hi("GitSignsChange", { fg = c.styx, bg = c.abyss })
hi("GitSignsDelete", { fg = c.cerberus, bg = c.abyss })
hi("GitSignsTopdelete", { fg = c.cerberus, bg = c.abyss })
hi("GitSignsChangedelete", { fg = c.amber_ore, bg = c.abyss })
hi("GitSignsUntracked", { fg = c.ash, bg = c.abyss })

-- ─── which-key ────────────────────────────────────────────────────────────────
hi("WhichKey", { fg = c.pale_gold })
hi("WhichKeyGroup", { fg = c.styx })
hi("WhichKeyDesc", { fg = c.bone })
hi("WhichKeySeperator", { fg = c.ash })
hi("WhichKeyFloat", { bg = c.cavern })
hi("WhichKeyBorder", { fg = c.slate, bg = c.cavern })

-- ─── indent-blankline ─────────────────────────────────────────────────────────
hi("IblIndent", { fg = c.stone })
hi("IblScope", { fg = c.slate })

-- ─── nvim-cmp ─────────────────────────────────────────────────────────────────
hi("CmpItemAbbr", { fg = c.bone })
hi("CmpItemAbbrMatch", { fg = c.pale_gold, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.gold_vein, bold = true })
hi("CmpItemAbbrDeprecated", { fg = c.ash, strikethrough = true })
hi("CmpItemMenu", { fg = c.ash, italic = true })
hi("CmpItemKindText", { fg = c.bone })
hi("CmpItemKindFunction", { fg = c.pale_gold })
hi("CmpItemKindMethod", { fg = c.pale_gold })
hi("CmpItemKindConstructor", { fg = c.persephone })
hi("CmpItemKindField", { fg = c.persephone })
hi("CmpItemKindVariable", { fg = c.shroud })
hi("CmpItemKindClass", { fg = c.styx })
hi("CmpItemKindInterface", { fg = c.styx })
hi("CmpItemKindModule", { fg = c.shroud })
hi("CmpItemKindProperty", { fg = c.persephone })
hi("CmpItemKindUnit", { fg = c.amber_ore })
hi("CmpItemKindValue", { fg = c.ivory })
hi("CmpItemKindEnum", { fg = c.styx })
hi("CmpItemKindKeyword", { fg = c.gold_vein })
hi("CmpItemKindSnippet", { fg = c.asphodel })
hi("CmpItemKindColor", { fg = c.amber_ore })
hi("CmpItemKindFile", { fg = c.bone })
hi("CmpItemKindReference", { fg = c.styx })
hi("CmpItemKindFolder", { fg = c.pale_gold })
hi("CmpItemKindEnumMember", { fg = c.amber_ore })
hi("CmpItemKindConstant", { fg = c.ivory })
hi("CmpItemKindStruct", { fg = c.styx })
hi("CmpItemKindEvent", { fg = c.cerberus })
hi("CmpItemKindOperator", { fg = c.asphodel })
hi("CmpItemKindTypeParameter", { fg = c.styx })

-- ─── lualine suggested colors (reference) ─────────────────────────────────────
-- normal:  bg=void,     fg=pale_gold,  accent=gold_vein
-- insert:  bg=void,     fg=persephone, accent=persephone
-- visual:  bg=void,     fg=styx,       accent=styx
-- replace: bg=void,     fg=cerberus,   accent=cerberus
-- command: bg=void,     fg=sulfur,     accent=sulfur
-- inactive:bg=void,     fg=ash

-- ─── Terminal colors ──────────────────────────────────────────────────────────
vim.g.terminal_color_0  = c.void
vim.g.terminal_color_1  = c.cerberus
vim.g.terminal_color_2  = c.persephone
vim.g.terminal_color_3  = c.amber_ore
vim.g.terminal_color_4  = c.styx
vim.g.terminal_color_5  = c.asphodel
vim.g.terminal_color_6  = c.styx_deep
vim.g.terminal_color_7  = c.bone
vim.g.terminal_color_8  = c.ash
vim.g.terminal_color_9  = "#d46860"
vim.g.terminal_color_10 = "#96c09e"
vim.g.terminal_color_11 = c.gold_vein
vim.g.terminal_color_12 = "#9aaae8"
vim.g.terminal_color_13 = c.styx
vim.g.terminal_color_14 = "#7a8aca"
vim.g.terminal_color_15 = c.specter
