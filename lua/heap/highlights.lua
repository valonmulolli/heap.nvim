-- Highlight definitions for the Heap theme
local highlight_utils = require("heap.highlight_utils")

local M = {}

-- Apply editor UI highlights
M.apply_editor_highlights = function(colors, opts)
	local get_bg = highlight_utils.get_background_func(opts)
	local get_custom_bg = function(element_type, default_bg)
		return highlight_utils.get_custom_bg(opts, element_type, default_bg)
	end

	-- Editor UI highlights
	vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = get_custom_bg("normal", colors.bg) })
	vim.api.nvim_set_hl(0, "NormalNC", { fg = colors.fg, bg = get_custom_bg("normal", colors.bg) })
	vim.api.nvim_set_hl(0, "TermCursor", { fg = colors.bg, bg = colors.cursor_fg })
	vim.api.nvim_set_hl(0, "TermCursorNC", { fg = colors.bg, bg = colors.cursor_fg })
	-- Visual highlight (ensure it's visible even in transparent mode)
	-- Check if user has set a custom visual background
	local custom_visual_bg = opts.tweak_background and opts.tweak_background.visual
	if custom_visual_bg ~= nil then
		-- Use custom visual background setting, respecting "none" value
		custom_visual_bg = custom_visual_bg == "none" and nil or custom_visual_bg
		vim.api.nvim_set_hl(0, "Visual", { bg = custom_visual_bg })
	else
		-- No custom setting, use default selection background (always visible)
		vim.api.nvim_set_hl(0, "Visual", { bg = colors.selection_bg })
	end
	vim.api.nvim_set_hl(0, "Cursor", { fg = colors.bg, bg = get_bg(colors.cursor_fg) })

	-- Apply cursorline option
	if opts.cursorline then
		vim.api.nvim_set_hl(0, "CursorLine", { bg = get_bg(colors.tab_active_bg) })
		vim.api.nvim_set_hl(0, "CursorColumn", { bg = get_bg(colors.tab_active_bg) })
	else
		vim.api.nvim_set_hl(0, "CursorLine", { bg = get_bg(nil) })
		vim.api.nvim_set_hl(0, "CursorColumn", { bg = get_bg(nil) })
	end

	vim.api.nvim_set_hl(0, "LineNr", { fg = colors.line_number_fg })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.line_number_active_fg })
	vim.api.nvim_set_hl(0, "SignColumn", { fg = colors.fg, bg = get_bg(colors.bg) })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.status_fg, bg = get_bg(colors.status_bg) })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.fg_dark, bg = get_bg(colors.status_bg) })
	vim.api.nvim_set_hl(0, "TabLine", { fg = colors.tab_inactive_fg, bg = get_bg(colors.tab_inactive_bg) })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.tab_active_fg, bg = get_bg(colors.tab_active_bg) })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = get_bg(colors.status_bg) })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.activity_bg })
	vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.activity_bg })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = get_bg(colors.tab_active_bg) })
	vim.api.nvim_set_hl(0, "Conceal", { fg = colors.fg_dark })
	vim.api.nvim_set_hl(0, "Directory", { fg = colors.term_blue })
	vim.api.nvim_set_hl(0, "DiffAdd", { bg = get_bg(colors.diff_added) })
	vim.api.nvim_set_hl(0, "DiffChange", { bg = get_bg(colors.selection_bg) }) -- Converted from #264f7833
	vim.api.nvim_set_hl(0, "DiffDelete", { bg = get_bg(colors.diff_removed) })
	vim.api.nvim_set_hl(0, "DiffText", { bg = get_bg(colors.selection_bg) }) -- Converted from #264f78aa
	if not opts.tweak_ui or opts.tweak_ui.enable_end_of_buffer ~= false then
		vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.bg })
	end
	vim.api.nvim_set_hl(0, "ErrorMsg", { fg = colors.invalid })
	vim.api.nvim_set_hl(0, "Folded", { fg = colors.fg_dark, bg = get_bg(colors.side_bar_bg) })
	vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.fg_dark, bg = get_bg(colors.bg) })
	vim.api.nvim_set_hl(
		0,
		"IncSearch",
		{ fg = colors.fg, bg = opts.transparent and colors.term_yellow or get_bg(colors.term_yellow) }
	)
	vim.api.nvim_set_hl(0, "Substitute", { fg = colors.bg, bg = get_bg(colors.term_yellow) })
	vim.api.nvim_set_hl(0, "MatchParen", { bg = get_bg(colors.bracket_match_bg) })
	vim.api.nvim_set_hl(0, "ModeMsg", { fg = colors.fg })
	vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.fg })
	vim.api.nvim_set_hl(0, "MsgSeparator", { fg = colors.fg })
	vim.api.nvim_set_hl(0, "MoreMsg", { fg = colors.term_green })
	vim.api.nvim_set_hl(0, "NonText", { fg = colors.fg_dark })
	vim.api.nvim_set_hl(0, "Pmenu", {
		fg = colors.fg,
		bg = get_custom_bg("menu", opts.transparent and colors.tab_active_bg or get_bg(colors.tab_active_bg)),
	})
	vim.api.nvim_set_hl(
		0,
		"PmenuSel",
		{ fg = colors.bg, bg = get_custom_bg("menu", opts.transparent and colors.keyword or get_bg(colors.keyword)) }
	)
	vim.api.nvim_set_hl(
		0,
		"PmenuSbar",
		{ bg = get_custom_bg("menu", opts.transparent and colors.tab_active_bg or get_bg(colors.tab_active_bg)) }
	)
	vim.api.nvim_set_hl(
		0,
		"PmenuThumb",
		{ bg = get_custom_bg("menu", opts.transparent and colors.fg_dark or get_bg(colors.fg_dark)) }
	)
	vim.api.nvim_set_hl(0, "Question", { fg = colors.term_green })
	vim.api.nvim_set_hl(
		0,
		"QuickFixLine",
		{ bg = opts.transparent and colors.selection_bg or get_bg(colors.selection_bg) }
	)
	vim.api.nvim_set_hl(0, "Search", { bg = opts.transparent and colors.keyword or get_bg(colors.keyword) }) -- Converted from #aadadb66
	vim.api.nvim_set_hl(0, "SpecialKey", { fg = colors.fg_dark })
	local undercurl_enabled = highlight_utils.is_undercurl_enabled(opts)
	vim.api.nvim_set_hl(0, "SpellBad", { fg = colors.invalid, undercurl = undercurl_enabled })
	vim.api.nvim_set_hl(0, "SpellCap", { fg = colors.term_yellow })
	vim.api.nvim_set_hl(0, "SpellLocal", { fg = colors.term_cyan })
	vim.api.nvim_set_hl(0, "SpellRare", { fg = colors.term_magenta })
	vim.api.nvim_set_hl(0, "StatusLineTerm", { fg = colors.status_fg, bg = get_bg(colors.status_bg) })
	vim.api.nvim_set_hl(0, "StatusLineTermNC", { fg = colors.fg_dark, bg = get_bg(colors.status_bg) })
	vim.api.nvim_set_hl(0, "WildMenu", { fg = colors.bg, bg = get_bg(colors.keyword) })
	vim.api.nvim_set_hl(0, "Title", { fg = colors.term_cyan })
	-- VisualNOS highlight (ensure it's visible even in transparent mode)
	-- Check if user has set a custom visualnos background
	local custom_visualnos_bg = opts.tweak_background and opts.tweak_background.visualnos
	if custom_visualnos_bg ~= nil then
		-- Use custom visualnos background setting, respecting "none" value
		custom_visualnos_bg = custom_visualnos_bg == "none" and nil or custom_visualnos_bg
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = custom_visualnos_bg })
	else
		-- No custom setting, use default selection background (always visible)
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.selection_bg })
	end
	vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.term_yellow })
	vim.api.nvim_set_hl(0, "Whitespace", { fg = colors.fg_dark })

	-- Float window highlights (for LSP, cmp, etc.)
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.keyword, bg = get_bg(colors.bg) })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = get_bg(colors.side_bar_bg) })
	vim.api.nvim_set_hl(0, "FloatTitle", { fg = colors.keyword, bg = get_bg(colors.bg), bold = true })

	-- WinBar highlights
	vim.api.nvim_set_hl(0, "WinBar", { fg = colors.status_fg, bg = get_bg(colors.status_bg) })
	vim.api.nvim_set_hl(0, "WinBarNC", { fg = colors.fg_dark, bg = get_bg(colors.status_bg) })
end

-- Apply syntax highlights
M.apply_syntax_highlights = function(colors, opts)
	-- Syntax highlights grouped for better organization and performance
	local syntax_highlights = {
		Comment = { fg = colors.comment },
		Constant = { fg = colors.constant_builtin },
		String = { fg = colors.string },
		Character = { fg = colors.string },
		Number = { fg = colors.number },
		Boolean = { fg = colors.number },
		Float = { fg = colors.number },
		Identifier = { fg = colors.variable },
		Function = { fg = colors.function_name },
		Statement = { fg = colors.keyword },
		Conditional = { fg = colors.keyword },
		Repeat = { fg = colors.keyword },
		Label = { fg = colors.keyword },
		Operator = { fg = colors.operators },
		Keyword = { fg = colors.keyword },
		Exception = { fg = colors.keyword },
		PreProc = { fg = colors.keyword },
		Include = { fg = colors.keyword },
		Define = { fg = colors.keyword },
		Macro = { fg = colors.keyword },
		PreCondit = { fg = colors.keyword },
		Type = { fg = colors.storage_type },
		StorageClass = { fg = colors.storage },
		Structure = { fg = colors.storage },
		Typedef = { fg = colors.storage },
		Special = { fg = colors.tag },
		SpecialChar = { fg = colors.string_escape },
		Tag = { fg = colors.tag },
		Delimiter = { fg = colors.punctuation },
		SpecialComment = { fg = colors.comment },
		Debug = { fg = colors.term_red },
		Underlined = { underline = true },
		Ignore = { fg = colors.fg },
		Error = { fg = colors.invalid },
		Todo = { fg = colors.term_yellow },
		ZigBuiltinFn = { fg = colors.zig_builtin_fn },
		ZigString = { fg = colors.zig_string },
		ZigStringDelimiter = { fg = colors.zig_string },
	}

	for hl_name, hl_def in pairs(syntax_highlights) do
		vim.api.nvim_set_hl(0, hl_name, hl_def)
	end
end

-- Apply treesitter highlights
M.apply_treesitter_highlights = function(colors, opts)
	-- Treesitter highlights
	local treesitter_highlights = {
		["@annotation"] = { fg = colors.tag },
		["@attribute"] = { fg = colors.tag_attribute },
		["@boolean"] = { fg = colors.number },
		["@character"] = { fg = colors.string },
		["@comment"] = { fg = colors.comment, italic = true },
		["@conditional"] = { fg = colors.control_flow },
		["@constant"] = { fg = colors.constant_builtin },
		["@constant.builtin"] = { fg = colors.constant_builtin },
		["@constant.macro"] = { fg = colors.constant_user },
		["@constructor"] = { fg = colors.class_name },
		["@error"] = { fg = colors.invalid },
		["@exception"] = { fg = colors.keyword },
		["@field"] = { fg = colors.property },
		["@function"] = { fg = colors.function_name },
		["@function.builtin"] = { fg = colors.library_function },
		["@function.call"] = { fg = colors.function_name },
		["@function.macro"] = { fg = colors.keyword },
		["@include"] = { fg = colors.keyword },
		["@keyword"] = { fg = colors.keyword },
		["@keyword.function"] = { fg = colors.storage },
		["@keyword.operator"] = { fg = colors.operators },
		["@keyword.return"] = { fg = colors.term_red },
		["@label"] = { fg = colors.tag_attribute },
		["@method"] = { fg = colors.function_name },
		["@method.call"] = { fg = colors.function_name },
		["@namespace"] = { fg = colors.class_name },
		["@number"] = { fg = colors.number },
		["@operator"] = { fg = colors.operators },
		["@parameter"] = { fg = colors.parameter },
		["@parameter.reference"] = { fg = colors.parameter },
		["@property"] = { fg = colors.property },
		["@punctuation.bracket"] = { fg = colors.punctuation },
		["@punctuation.delimiter"] = { fg = colors.punctuation },
		["@punctuation.special"] = { fg = colors.punctuation },
		["@repeat"] = { fg = colors.control_flow },
		["@string"] = { fg = colors.string },
		["@string.escape"] = { fg = colors.string_escape },
		["@string.special"] = { fg = colors.string_escape },
		["@symbol"] = { fg = colors.constant_builtin },
		["@tag"] = { fg = colors.tag },
		["@tag.attribute"] = { fg = colors.tag_attribute },
		["@tag.delimiter"] = { fg = colors.tag_start_end },
		["@text"] = { fg = colors.fg },
		["@text.strong"] = { fg = colors.markdown_italic, bold = true },
		["@text.emphasis"] = { fg = colors.markdown_italic, italic = true },
		["@text.underline"] = { underline = true },
		["@text.strike"] = { strikethrough = true },
		["@text.title"] = { fg = colors.markdown_heading, bold = true },
		["@text.literal"] = { fg = colors.string },
		["@text.quote"] = { fg = colors.comment },
		["@text.uri"] = { fg = colors.markdown_link, underline = true },
		["@text.math"] = { fg = colors.number },
		["@text.environment"] = { fg = colors.tag },
		["@text.environment.name"] = { fg = colors.tag },
		["@text.reference"] = { fg = colors.markdown_link },
		["@text.todo"] = { fg = colors.term_yellow },
		["@text.note"] = { fg = colors.term_cyan },
		["@text.warning"] = { fg = colors.term_yellow },
		["@text.danger"] = { fg = colors.term_red },
		["@type"] = { fg = colors.storage_type },
		["@type.builtin"] = { fg = colors.library_type },
		["@variable"] = { fg = colors.variable },
		["@variable.builtin"] = { fg = colors.this_keyword },

		-- Additional Treesitter highlights for enhanced syntax support
		["@module"] = { fg = colors.class_name },
		["@module.builtin"] = { fg = colors.library_type },
		["@property.class"] = { fg = colors.property },
		["@property.enum"] = { fg = colors.property },
		["@type.definition"] = { fg = colors.storage_type },
		["@type.qualifier"] = { fg = colors.storage },
		["@storageclass"] = { fg = colors.storage },
		["@storageclass.lifetime"] = { fg = colors.storage },
		["@lsp.type.lifetime"] = { link = "@storageclass.lifetime" },
		["@lsp.typemod.variable.constant"] = { link = "@constant" },
		["@lsp.typemod.variable.readonly"] = { fg = colors.constant_builtin },
		["@lsp.typemod.property.constant"] = { link = "@constant" },
		["@lsp.typemod.property.readonly"] = { fg = colors.property },
		["@lsp.typemod.function.associated"] = { link = "@function" },
		["@lsp.typemod.keyword.injected"] = { fg = colors.keyword },
		["@lsp.typemod.string.injected"] = { fg = colors.string },
		["@lsp.typemod.type.injected"] = { fg = colors.storage_type },
		["@string.regex"] = { fg = colors.string_escape },
		["@string.pattern"] = { fg = colors.string_escape },
		["@variable.parameter"] = { fg = colors.parameter },
		["@variable.member"] = { fg = colors.property },

		-- LSP Semantic Highlighting
		["@lsp.type.class"] = { link = "@type" },
		["@lsp.type.comment"] = { link = "@comment" },
		["@lsp.type.decorator"] = { link = "@constant" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.enumMember"] = { link = "@constant" },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.interface"] = { link = "@type" },
		["@lsp.type.macro"] = { link = "@function.macro" },
		["@lsp.type.method"] = { link = "@function" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.struct"] = { link = "@type" },
		["@lsp.type.typeAlias"] = { link = "@type" },
		["@lsp.type.variable"] = { link = "@variable" },
		-- Extended LSP semantic highlighting
		["@lsp.type.commentBlock"] = { link = "@comment" },
		["@lsp.type.decoratorMethod"] = { link = "@function" },
		["@lsp.type.derive"] = { link = "@keyword" },
		["@lsp.type.generic"] = { link = "@type" },
		["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
		["@lsp.type.typeParameter"] = { link = "@type.definition" },
	}

	for hl_name, hl_def in pairs(treesitter_highlights) do
		vim.api.nvim_set_hl(0, hl_name, hl_def)
	end
end

-- Apply git related highlights
M.apply_git_highlights = function(colors, opts)
	-- Git signs (if using gitsigns plugin)
	vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.git_decoration_added })
	vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.git_decoration_modified })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.git_decoration_deleted })
	vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = colors.git_added })
	vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = colors.git_modified })
	vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = colors.git_deleted })
	vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = colors.comment })

	-- Plugin-specific highlights (only if enabled)
	if opts.plugins and opts.plugins.gitsigns then
		vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = highlight_utils.get_background_func(opts)(colors.diff_added) })
		vim.api.nvim_set_hl(
			0,
			"GitSignsDeleteLn",
			{ bg = highlight_utils.get_background_func(opts)(colors.diff_removed) }
		)
	end
end

-- Apply diagnostic highlights
M.apply_diagnostic_highlights = function(colors, opts)
	local get_bg = highlight_utils.get_background_func(opts)
	local undercurl_enabled = highlight_utils.is_undercurl_enabled(opts)

	-- Diagnostic highlights
	vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.invalid })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.term_yellow })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.term_blue })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.term_cyan })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = colors.invalid, bg = get_bg(colors.tab_active_bg) })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = colors.term_yellow, bg = get_bg(colors.tab_active_bg) })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = colors.term_blue, bg = get_bg(colors.tab_active_bg) })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = colors.term_cyan, bg = get_bg(colors.tab_active_bg) })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = undercurl_enabled, sp = colors.invalid })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = undercurl_enabled, sp = colors.term_yellow })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = undercurl_enabled, sp = colors.term_blue })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = undercurl_enabled, sp = colors.term_cyan })
end

-- Apply completion menu highlights
M.apply_completion_highlights = function(colors, opts)
	-- Nvim-cmp completion menu highlights
	local completion_highlights = {
		CmpItemAbbr = { fg = colors.fg },
		CmpItemAbbrDeprecated = { fg = colors.fg_dark, strikethrough = true },
		CmpItemAbbrMatch = { fg = colors.term_yellow, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = colors.term_yellow, bold = true },
		CmpItemMenu = { fg = colors.comment },
		CmpItemKind = { fg = colors.keyword },
		CmpItemKindText = { fg = colors.string },
		CmpItemKindMethod = { fg = colors.function_name },
		CmpItemKindFunction = { fg = colors.function_name },
		CmpItemKindConstructor = { fg = colors.class_name },
		CmpItemKindField = { fg = colors.property },
		CmpItemKindVariable = { fg = colors.variable },
		CmpItemKindClass = { fg = colors.class_name },
		CmpItemKindInterface = { fg = colors.class_name },
		CmpItemKindModule = { fg = colors.class_name },
		CmpItemKindProperty = { fg = colors.property },
		CmpItemKindUnit = { fg = colors.number },
		CmpItemKindValue = { fg = colors.constant_builtin },
		CmpItemKindEnum = { fg = colors.type },
		CmpItemKindKeyword = { fg = colors.keyword },
		CmpItemKindSnippet = { fg = colors.tag },
		CmpItemKindColor = { fg = colors.term_cyan },
		CmpItemKindFile = { fg = colors.term_blue },
		CmpItemKindReference = { fg = colors.term_magenta },
		CmpItemKindFolder = { fg = colors.term_blue },
		CmpItemKindEnumMember = { fg = colors.constant_builtin },
		CmpItemKindConstant = { fg = colors.constant_builtin },
		CmpItemKindStruct = { fg = colors.type },
		CmpItemKindEvent = { fg = colors.keyword },
		CmpItemKindOperator = { fg = colors.operators },
		CmpItemKindTypeParameter = { fg = colors.type },
	}

	for hl_name, hl_def in pairs(completion_highlights) do
		vim.api.nvim_set_hl(0, hl_name, hl_def)
	end
end

-- Apply telescope highlights
M.apply_telescope_highlights = function(colors, opts)
	local get_custom_bg = function(element_type, default_bg)
		return highlight_utils.get_custom_bg(opts, element_type, default_bg)
	end

	-- Telescope highlights
	vim.api.nvim_set_hl(0, "TelescopeNormal", {
		fg = colors.fg,
		bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_bg)),
	})
	vim.api.nvim_set_hl(0, "TelescopeBorder", {
		fg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_bg)),
		bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_bg)),
	})
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", {
		fg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_border)),
		bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_border)),
	})
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {
		fg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_bg)),
		bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_bg)),
	})
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {
		fg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_bg)),
		bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.panel_bg)),
	})
end

-- Apply nvim-tree highlights
M.apply_nvim_tree_highlights = function(colors, opts)
	local get_bg = highlight_utils.get_background_func(opts)
	local get_custom_bg = function(element_type, default_bg)
		return highlight_utils.get_custom_bg(opts, element_type, default_bg)
	end

	-- NvimTree highlights (respecting transparency option)
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = colors.fg, bg = get_custom_bg("nvimtree", get_bg(colors.bg)) })
	vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = colors.sidebar_title_fg })
	vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = colors.git_decoration_modified })
	vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = colors.git_decoration_added })
	vim.api.nvim_set_hl(0, "NvimTreeGitMerge", { fg = colors.git_decoration_conflicting })
	vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = colors.git_decoration_untracked })
	vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = colors.git_decoration_deleted })
	vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = colors.term_yellow, underline = true })
	vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = colors.indent_guide_active_bg })
	vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = colors.term_cyan })
	vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = colors.fg, bold = true })

	if opts.plugins and opts.plugins.nvim_tree then
		vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = colors.term_cyan, bold = true })
		vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = colors.term_green })
	end
end

-- Apply bufferline highlights
M.apply_bufferline_highlights = function(colors, opts)
	local get_bg = highlight_utils.get_background_func(opts)

	-- Bufferline support for tab/buffer management (darker colors for heap-dark)
	if opts.plugins and opts.plugins.bufferline then
		vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = colors.title_active_bg })
		vim.api.nvim_set_hl(0, "BufferLineFill", { bg = get_bg(colors.title_active_bg) })
		vim.api.nvim_set_hl(
			0,
			"BufferLineBackground",
			{ fg = colors.activity_inactive_fg, bg = get_bg(colors.title_active_bg) }
		)
		vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(
			0,
			"BufferLineBufferSelected",
			{ fg = colors.fg, bg = get_bg(colors.title_active_bg), bold = true }
		)
		vim.api.nvim_set_hl(0, "BufferLineCloseButtonVisible", { fg = colors.activity_inactive_fg })
		vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = colors.term_red })
		vim.api.nvim_set_hl(
			0,
			"BufferLineTab",
			{ fg = colors.activity_inactive_fg, bg = get_bg(colors.title_active_bg) }
		)
		vim.api.nvim_set_hl(
			0,
			"BufferLineTabSelected",
			{ fg = colors.activity_fg, bg = get_bg(colors.title_active_bg), bold = true }
		)
		vim.api.nvim_set_hl(0, "BufferLineTabClose", { fg = colors.term_red })
		vim.api.nvim_set_hl(
			0,
			"BufferLineOffsetSeparator",
			{ fg = colors.title_active_bg, bg = get_bg(colors.title_active_bg) }
		)
	end
end

-- Apply other plugin highlights
M.apply_plugin_highlights = function(colors, opts)
	local get_bg = highlight_utils.get_background_func(opts)
	local get_custom_bg = function(element_type, default_bg)
		return highlight_utils.get_custom_bg(opts, element_type, default_bg)
	end
	if opts.plugins and opts.plugins.telescope then
		vim.api.nvim_set_hl(
			0,
			"TelescopePromptNormal",
			{
				fg = colors.fg,
				bg = get_custom_bg("telescope",
					highlight_utils.get_background_func(opts)(colors.tab_active_bg))
			}
		)
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", {
			fg = colors.keyword,
			bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.status_bg)),
		})
		vim.api.nvim_set_hl(
			0,
			"TelescopeResultsNormal",
			{ fg = colors.fg, bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.bg)) }
		)
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {
			fg = colors.comment,
			bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.bg)),
		})
		vim.api.nvim_set_hl(
			0,
			"TelescopePreviewNormal",
			{ fg = colors.fg, bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.bg)) }
		)
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {
			fg = colors.comment,
			bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.bg)),
		})
		vim.api.nvim_set_hl(
			0,
			"TelescopeSelection",
			{
				fg = colors.fg,
				bg = get_custom_bg("telescope",
					highlight_utils.get_background_func(opts)(colors.selection_bg))
			}
		)
		vim.api.nvim_set_hl(0, "TelescopeMultiSelection", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.term_yellow, bold = true })
	end

	if opts.plugins and opts.plugins.which_key then
		vim.api.nvim_set_hl(0, "WhichKey", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = get_bg(nil) })
	end

	if opts.plugins and opts.plugins.dashboard then
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "DashboardCenter", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "DashboardFooter", { fg = colors.keyword, bold = true })
	end

	if opts.plugins and opts.plugins.indent_blankline then
		vim.api.nvim_set_hl(0, "IblIndent", { fg = get_bg(colors.indent_guide_bg) })
		vim.api.nvim_set_hl(0, "IblScope", { fg = colors.term_blue })
	end

	-- Neo-tree support (modern file explorer)
	if opts.plugins and opts.plugins.neo_tree then
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = colors.fg, bg = get_custom_bg("neotree", get_bg(colors.bg)) })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { fg = colors.fg, bg = get_custom_bg("neotree", get_bg(colors.bg)) })
		vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = colors.sidebar_title_fg, bold = true })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = colors.term_green })
		vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = colors.git_decoration_added })
		vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.git_decoration_modified })
		vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = colors.git_decoration_deleted })
		vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = colors.git_decoration_untracked })
		vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = colors.git_decoration_conflicting })
	end

	-- Trouble support (diagnostics panel)
	if opts.plugins and opts.plugins.trouble then
		vim.api.nvim_set_hl(0, "TroubleNormal", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "TroubleText", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "TroubleSource", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "TroubleCode", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "TroubleCount", { fg = colors.term_yellow, bg = get_bg(colors.tab_active_bg) })
		vim.api.nvim_set_hl(0, "TroubleError", { fg = colors.invalid })
		vim.api.nvim_set_hl(0, "TroubleWarning", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "TroubleInformation", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "TroubleHint", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "TroubleSignError", { fg = colors.invalid })
		vim.api.nvim_set_hl(0, "TroubleSignWarning", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "TroubleSignInformation", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "TroubleSignHint", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "TroubleSignOther", { fg = colors.term_magenta })
		vim.api.nvim_set_hl(0, "TroubleFoldIcon", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "TroubleIndent", { fg = colors.fg_dark })
	end

	-- Noice support (notification UI)
	if opts.plugins and opts.plugins.noice then
		vim.api.nvim_set_hl(0, "NoiceCursor", { fg = colors.bg, bg = colors.cursor_fg })
		vim.api.nvim_set_hl(0, "NoiceMini", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = colors.keyword, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(
			0,
			"NoiceCmdlinePopupBorderSearch",
			{ fg = colors.term_yellow, bg = get_bg(colors.side_bar_bg) }
		)
		vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = colors.keyword, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceFormatProgressDone", { fg = colors.term_green, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceFormatProgressTodo", { fg = colors.term_yellow, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceLspProgressSpinner", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "NoiceLspProgressTitle", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "NoiceLspProgressClient", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "NoicePopup", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = colors.keyword, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoicePopupmenu", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = colors.keyword, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = colors.term_yellow, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { fg = colors.bg, bg = colors.keyword })
		vim.api.nvim_set_hl(0, "NoiceSplit", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceSplitBorder", { fg = colors.keyword, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "NoiceVirtualText", { fg = colors.comment })
	end

	-- Notify support (nvim-notify)
	if opts.plugins and opts.plugins.notify ~= false then
		vim.api.nvim_set_hl(0, "NotifyBackground", { bg = colors.bg })
		vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.invalid })
		vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = colors.invalid })
		vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = colors.invalid })
		vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = colors.fg })
	end

	-- Mini.nvim components support
	if opts.plugins and opts.plugins.mini then
		-- MiniStatusline
		vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = colors.bg, bg = colors.term_blue, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = colors.bg, bg = colors.term_green, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = colors.bg, bg = colors.term_magenta, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = colors.bg, bg = colors.term_red, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = colors.bg, bg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = colors.bg, bg = colors.term_cyan, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = colors.fg, bg = get_bg(colors.status_bg) })
		vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = colors.fg, bg = get_bg(colors.status_bg) })
		vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = colors.fg, bg = get_bg(colors.status_bg) })
		vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { fg = colors.fg_dark, bg = get_bg(colors.status_bg) })

		-- MiniTabline
		vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = colors.fg, bg = get_bg(colors.tab_active_bg), bold = true })
		vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = colors.fg, bg = get_bg(colors.tab_inactive_bg) })
		vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = colors.fg_dark, bg = get_bg(colors.tab_inactive_bg) })
		vim.api.nvim_set_hl(
			0,
			"MiniTablineModifiedCurrent",
			{ fg = colors.term_yellow, bg = get_bg(colors.tab_active_bg), bold = true }
		)
		vim.api.nvim_set_hl(
			0,
			"MiniTablineModifiedVisible",
			{ fg = colors.term_yellow, bg = get_bg(colors.tab_inactive_bg) }
		)
		vim.api.nvim_set_hl(
			0,
			"MiniTablineModifiedHidden",
			{ fg = colors.term_yellow, bg = get_bg(colors.tab_inactive_bg) }
		)
		vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = get_bg(colors.status_bg) })
		vim.api.nvim_set_hl(
			0,
			"MiniTablineTabpagesection",
			{ fg = colors.term_blue, bg = get_bg(colors.status_bg), bold = true }
		)

		-- MiniIndentscope
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff", { fg = colors.fg_dark })

		-- MiniCursorword
		vim.api.nvim_set_hl(0, "MiniCursorword", { bg = get_bg(colors.selection_bg) })
		vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = get_bg(colors.selection_bg) })

		-- MiniCompletion
		vim.api.nvim_set_hl(0, "MiniCompletionActiveParameter", { underline = true })

		-- MiniJump
		vim.api.nvim_set_hl(0, "MiniJump", { fg = colors.bg, bg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "MiniJump2dSpot", { fg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "MiniJump2dSpotAhead", { fg = colors.term_blue, bold = true })
		vim.api.nvim_set_hl(0, "MiniJump2dSpotUnique", { fg = colors.term_green, bold = true })
	end

	-- Flash/Leap support (motion highlights)
	if opts.plugins and opts.plugins.flash then
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = colors.bg, bg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "FlashMatch", { fg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "FlashCurrent", { fg = colors.bg, bg = colors.term_blue, bold = true })
		vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "FlashPrompt", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "FlashPromptIcon", { fg = colors.term_yellow })
	end

	-- Blink.cmp support (modern completion plugin)
	if opts.plugins and opts.plugins.blink then
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", {
			fg = colors.fg,
			bg = get_custom_bg("menu", opts.transparent and colors.tab_active_bg or get_bg(colors.tab_active_bg)),
		})
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = colors.keyword, bg = get_bg(colors.bg) })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", {
			fg = colors.bg,
			bg = get_custom_bg("menu", opts.transparent and colors.keyword or get_bg(colors.keyword)),
		})
		vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { fg = colors.fg_dark, strikethrough = true })
		vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = colors.string })
		vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = colors.function_name })
		vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = colors.function_name })
		vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = colors.class_name })
		vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = colors.property })
		vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = colors.variable })
		vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = colors.class_name })
		vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = colors.class_name })
		vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = colors.class_name })
		vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = colors.property })
		vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", { fg = colors.number })
		vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = colors.constant_builtin })
		vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = colors.type })
		vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = colors.tag })
		vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = colors.term_magenta })
		vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = colors.constant_builtin })
		vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = colors.constant_builtin })
		vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = colors.type })
		vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = colors.operators })
		vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = colors.type })
		vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = colors.comment })
	end

	-- Lazy.nvim support
	if opts.plugins and opts.plugins.lazy then
		vim.api.nvim_set_hl(0, "LazyNormal", { bg = get_bg(colors.side_bar_bg), fg = colors.fg })
		vim.api.nvim_set_hl(0, "LazyButton", { bg = colors.tab_active_bg, fg = colors.fg })
		vim.api.nvim_set_hl(
			0,
			"LazyButtonActive",
			{ bg = colors.selection_bg, fg = colors.activity_fg, bold = true }
		)
		vim.api.nvim_set_hl(0, "LazyH1", { fg = colors.sidebar_title_fg, bold = true })
		vim.api.nvim_set_hl(0, "LazySpecial", { fg = colors.term_blue })
	end

	-- Mason.nvim support
	if opts.plugins and opts.plugins.mason then
		vim.api.nvim_set_hl(0, "MasonNormal", { link = "LazyNormal" })
		vim.api.nvim_set_hl(0, "MasonHeader", { link = "LazyH1" })
		vim.api.nvim_set_hl(0, "MasonHighlight", { fg = colors.term_cyan })
	end

	-- Snacks.nvim support
	if opts.plugins and opts.plugins.snacks then
		vim.api.nvim_set_hl(0, "SnacksDashboardNormal", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "SnacksNotifierInfo", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "SnacksNotifierWarn", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "SnacksNotifierError", { fg = colors.invalid })
		vim.api.nvim_set_hl(0, "SnacksPicker", { bg = get_bg(colors.bg) })
	end

	-- Additional missing highlight groups
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.activity_bg })
	vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.activity_bg })
	vim.api.nvim_set_hl(0, "FloatShadow", { bg = colors.bg, blend = 80 })
	vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = colors.bg, blend = 100 })

	-- LSP Inlay Hints (Neovim 0.10+)
	vim.api.nvim_set_hl(0, "LspInlayHint", { fg = colors.comment, bg = get_bg(colors.tab_active_bg), italic = true })

	-- render-markdown.nvim support
	if opts.plugins and opts.plugins.render_markdown ~= false then
		vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = colors.term_cyan, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = colors.keyword, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = colors.term_green, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = colors.term_blue, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = colors.term_magenta, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = get_bg(colors.tab_active_bg) })
		vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { fg = colors.string, bg = get_bg(colors.tab_active_bg) })
		vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "RenderMarkdownCheckedBox", { fg = colors.term_green })
		vim.api.nvim_set_hl(0, "RenderMarkdownUncheckedBox", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "RenderMarkdownQuote", { fg = colors.comment, italic = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = colors.markdown_link, underline = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { fg = colors.keyword, bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { fg = colors.fg })
	end

	-- fzf-lua support
	if opts.plugins and opts.plugins.fzf_lua ~= false then
		vim.api.nvim_set_hl(0, "FzfLuaNormal", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = colors.keyword, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = colors.sidebar_title_fg, bold = true })
		vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { fg = colors.fg, bg = get_bg(colors.bg) })
		vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { fg = colors.comment, bg = get_bg(colors.bg) })
		vim.api.nvim_set_hl(0, "FzfLuaCursor", { fg = colors.bg, bg = colors.keyword })
		vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { bg = get_bg(colors.selection_bg) })
		vim.api.nvim_set_hl(0, "FzfLuaSearch", { fg = colors.term_yellow, bold = true })
		vim.api.nvim_set_hl(0, "FzfLuaHeaderBind", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { fg = colors.comment })
	end

	-- oil.nvim support
	if opts.plugins and opts.plugins.oil ~= false then
		vim.api.nvim_set_hl(0, "OilDir", { fg = colors.term_cyan, bold = true })
		vim.api.nvim_set_hl(0, "OilDirIcon", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "OilFile", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "OilLink", { fg = colors.keyword, underline = true })
		vim.api.nvim_set_hl(0, "OilLinkTarget", { fg = colors.comment })
		vim.api.nvim_set_hl(0, "OilCopy", { fg = colors.term_green })
		vim.api.nvim_set_hl(0, "OilMove", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "OilChange", { fg = colors.git_decoration_modified })
		vim.api.nvim_set_hl(0, "OilCreate", { fg = colors.git_decoration_added })
		vim.api.nvim_set_hl(0, "OilDelete", { fg = colors.git_decoration_deleted })
		vim.api.nvim_set_hl(0, "OilPermissionNone", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "OilPermissionRead", { fg = colors.term_yellow })
		vim.api.nvim_set_hl(0, "OilPermissionWrite", { fg = colors.term_red })
		vim.api.nvim_set_hl(0, "OilPermissionExecute", { fg = colors.term_green })
		vim.api.nvim_set_hl(0, "OilTypeDir", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "OilTypeFile", { fg = colors.fg })
		vim.api.nvim_set_hl(0, "OilTypeLink", { fg = colors.keyword })
	end

	-- harpoon2 support
	if opts.plugins and opts.plugins.harpoon ~= false then
		vim.api.nvim_set_hl(0, "HarpoonWindow", { fg = colors.fg, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = colors.keyword, bg = get_bg(colors.side_bar_bg) })
		vim.api.nvim_set_hl(0, "HarpoonTitle", { fg = colors.sidebar_title_fg, bold = true })
		vim.api.nvim_set_hl(0, "HarpoonCurrentFile", { fg = colors.term_green, bold = true })
	end

	-- Additional Treesitter captures
	vim.api.nvim_set_hl(0, "@text.todo.checked", { fg = colors.term_green })
	vim.api.nvim_set_hl(0, "@text.todo.unchecked", { fg = colors.term_yellow })
	vim.api.nvim_set_hl(0, "@text.diff.add", { fg = colors.git_decoration_added })
	vim.api.nvim_set_hl(0, "@text.diff.delete", { fg = colors.git_decoration_deleted })

	-- Additional LSP semantic highlights
	vim.api.nvim_set_hl(0, "@lsp.mod.defaultLibrary", { fg = colors.library_function })
	vim.api.nvim_set_hl(0, "@lsp.mod.deprecated", { fg = colors.fg_dark, strikethrough = true })
	vim.api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary", { fg = colors.library_function })
	vim.api.nvim_set_hl(0, "@lsp.typemod.method.defaultLibrary", { fg = colors.library_function })
	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = colors.library_constant })
	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.globalScope", { fg = colors.constant_builtin })
end

-- Apply manual highlight overrides
M.apply_custom_highlights = function(opts)
	if opts.tweak_highlight then
		for hl_name, hl_def in pairs(opts.tweak_highlight) do
			vim.api.nvim_set_hl(0, hl_name, hl_def)
		end
	end
end

-- Apply terminal colors
M.apply_terminal_colors = function(colors)
	vim.g.terminal_color_0 = colors.term_black
	vim.g.terminal_color_1 = colors.term_red
	vim.g.terminal_color_2 = colors.term_green
	vim.g.terminal_color_3 = colors.term_yellow
	vim.g.terminal_color_4 = colors.term_blue
	vim.g.terminal_color_5 = colors.term_magenta
	vim.g.terminal_color_6 = colors.term_cyan
	vim.g.terminal_color_7 = colors.term_white
	vim.g.terminal_color_8 = colors.term_bright_black
	vim.g.terminal_color_9 = colors.term_bright_red
	vim.g.terminal_color_10 = colors.term_bright_green
	vim.g.terminal_color_11 = colors.term_bright_yellow
	vim.g.terminal_color_12 = colors.term_bright_blue
	vim.g.terminal_color_13 = colors.term_bright_magenta
	vim.g.terminal_color_14 = colors.term_bright_cyan
	vim.g.terminal_color_15 = colors.term_bright_white
end

-- Apply all highlights for a theme
M.apply_all_highlights = function(colors, opts)
	M.apply_editor_highlights(colors, opts)
	M.apply_syntax_highlights(colors, opts)
	M.apply_treesitter_highlights(colors, opts)
	M.apply_git_highlights(colors, opts)
	M.apply_diagnostic_highlights(colors, opts)
	M.apply_completion_highlights(colors, opts)
	M.apply_telescope_highlights(colors, opts)
	M.apply_nvim_tree_highlights(colors, opts)
	M.apply_bufferline_highlights(colors, opts)
	M.apply_plugin_highlights(colors, opts)
	M.apply_terminal_colors(colors)
	M.apply_custom_highlights(opts)
end

return M
