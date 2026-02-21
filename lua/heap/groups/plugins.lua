-- Highlight group: plugin integrations
local highlight_utils = require("heap.highlight_utils")

local M = {}

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
		vim.api.nvim_set_hl(
			0,
			"TelescopeResultsNormal",
			{ fg = colors.fg, bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.bg)) }
		)
		vim.api.nvim_set_hl(
			0,
			"TelescopePreviewNormal",
			{ fg = colors.fg, bg = get_custom_bg("telescope", highlight_utils.get_background_func(opts)(colors.bg)) }
		)
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
		vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = colors.storage_type })
		vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = colors.tag })
		vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = colors.term_magenta })
		vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = colors.term_blue })
		vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = colors.constant_builtin })
		vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = colors.constant_builtin })
		vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = colors.storage_type })
		vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = colors.operators })
		vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = colors.storage_type })
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

	-- zignite.nvim support (optional custom groups for border/title wiring)
	if opts.plugins and opts.plugins.zignite then
		vim.api.nvim_set_hl(0, "ZigniteBorder", { fg = colors.keyword, bg = get_bg(colors.bg) })
		vim.api.nvim_set_hl(0, "ZigniteBorderSuccess", { fg = colors.term_green, bg = get_bg(colors.bg) })
		vim.api.nvim_set_hl(0, "ZigniteBorderError", { fg = colors.invalid, bg = get_bg(colors.bg) })
		vim.api.nvim_set_hl(0, "ZigniteTitle", { fg = colors.sidebar_title_fg, bold = true })
		vim.api.nvim_set_hl(0, "ZigniteFooter", { fg = colors.comment })
	end

	-- Additional Treesitter captures
	vim.api.nvim_set_hl(0, "@text.todo.checked", { fg = colors.term_green })
	vim.api.nvim_set_hl(0, "@text.todo.unchecked", { fg = colors.term_yellow })
	vim.api.nvim_set_hl(0, "@text.diff.add", { fg = colors.git_decoration_added })
	vim.api.nvim_set_hl(0, "@text.diff.delete", { fg = colors.git_decoration_deleted })
	vim.api.nvim_set_hl(0, "@markup.list.checked", { fg = colors.term_green })
	vim.api.nvim_set_hl(0, "@markup.list.unchecked", { fg = colors.term_yellow })

	-- Additional LSP semantic highlights
	vim.api.nvim_set_hl(0, "@lsp.mod.defaultLibrary", { fg = colors.library_function })
	vim.api.nvim_set_hl(0, "@lsp.mod.deprecated", { fg = colors.fg_dark, strikethrough = true })
	vim.api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary", { fg = colors.library_function })
	vim.api.nvim_set_hl(0, "@lsp.typemod.method.defaultLibrary", { fg = colors.library_function })
	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = colors.library_constant })
	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.globalScope", { fg = colors.constant_builtin })
end

-- Apply manual highlight overrides

function M.apply(colors, opts)
	M.apply_plugin_highlights(colors, opts)
end

return M
