-- Highlight group: base UI + terminal colors
local highlight_utils = require("heap.highlight_utils")

local M = {}

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

function M.apply(colors, opts)
	M.apply_editor_highlights(colors, opts)
	M.apply_terminal_colors(colors)
end

return M
