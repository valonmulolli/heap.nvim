-- Color definitions for the Heap theme
local M = {}

-- Define the color palette based on the Heap VS Code theme
M.default_colors = {
	bg = "#121212",
	fg = "#d4d4d4",
	fg_dark = "#606060",

	-- Activity bar and sidebar
	activity_bg = "#0a0a0a",
	side_bar_bg = "#1a1a1a",
	tab_active_bg = "#2a2a2a",
	tab_inactive_bg = "#121212",

	-- Status bar
	status_bg = "#0a0a0a",
	status_fg = "#aadadb",

	-- Editor elements
	cursor_fg = "#aadadb",
	line_number_fg = "#606060",
	line_number_active_fg = "#aadadb",
	selection_bg = "#264f78",
	selection_fg = "#c2ffdf",
	bracket_match_bg = "#264f78",
	bracket_match_border = "#8fbcbb",
	indent_guide_bg = "#2a2a2a",
	indent_guide_active_bg = "#3a3a3a",

	-- Git and diff
	git_added = "#1c6b48",
	git_modified = "#1c6b48",
	git_deleted = "#f44747",
	diff_added = "#1c6b48", -- Converted from #1c6b4833
	diff_removed = "#f44747", -- Converted from #f4474733

	-- Git decorations
	git_decoration_added = "#8fbcbb",
	git_decoration_modified = "#8fbcbb",
	git_decoration_deleted = "#FF204E",
	git_decoration_untracked = "#8fbcbb",
	git_decoration_ignored = "#606060",
	git_decoration_conflicting = "#FFD700",
	git_decoration_submodule = "#8fbcbb",

	-- Terminal colors
	term_black = "#0a0a0a",
	term_red = "#FF204E",
	term_green = "#6a9955",
	term_yellow = "#DFFF00",
	term_blue = "#1398b9",
	term_magenta = "#aadadb",
	term_cyan = "#8fbcbb",
	term_white = "#d4d4d4",
	term_bright_black = "#606060",
	term_bright_red = "#FF204E",
	term_bright_green = "#afffaf",
	term_bright_yellow = "#DCFFB7",
	term_bright_blue = "#98e4ff",
	term_bright_magenta = "#aadadb",
	term_bright_cyan = "#aadadb",
	term_bright_white = "#ffffff",

	-- Syntax colors
	comment = "#74dbb2", -- Converted from #74dbb2e7
	string = "#afffaf",
	string_escape = "#96ceb4",
	number = "#6eafad",
	constant_builtin = "#B9E602",
	constant_user = "#B9E602",
	variable = "#f2e9e1",
	keyword = "#aadadb",
	storage = "#aadadb",
	storage_type = "#fcfaee",
	class_name = "#fcfaee",
	function_name = "#1398b9",
	variable_start = "#287691",
	embedded = "#7ab8b8",
	tag = "#aadadb",
	tag_start_end = "#e7e9db",
	tag_attribute = "#DFFF00",
	library_function = "#aadadb",
	library_constant = "#B9E602",
	library_type = "#f1f1f1",
	this_keyword = "#aadadb",
	zig_builtin_fn = "#aadadb", -- Default for Zig builtins
	invalid = "#FF204E",
	json_key = "#DCFFB7",
	markdown_heading = "#aadadb",
	markdown_link = "#aadadb",
	markdown_list = "#DFFF00",
	markdown_italic = "#287691",
	punctuation = "#31ffb6",
	operators = "#287691",
	property = "#79daed",
	parameter = "#f8f9f0",
	private_property = "#7ab8b8",
	control_flow = "#aadadb",
	bracket_fg_1 = "#FF204E",
	bracket_fg_2 = "#005f87",
	bracket_fg_3 = "#6eafad",
	bracket_unexpected = "#FF204E",
	title_active_bg = "#0a0a0a",
	title_active_fg = "#c2ffdf",
	tab_active_fg = "#aadadb",
	tab_inactive_fg = "#8fbcbb",
	sidebar_title_fg = "#c2ffdf",
	activity_badge_bg = "#8fbcbb",
	activity_fg = "#c2ffdf",
	activity_inactive_fg = "#8fbcbb",
	sidebar_section_header_bg = "#1a1a1a",
	panel_bg = "#1a1a1a",
	panel_border = "#0a0a0a",
	zig_string = "#afffaf", -- Default for Zig strings (green)
}

-- Define the dark theme color palette
M.dark_colors = {
	-- User Provided Palette
	-- Night Black: #09090b (bg)
	-- Sea Green: #6eafad (primary accent)
	-- Teal Accent: #3fb6a6 (secondary accent)
	-- Chartreuse: #dfff00 (pop/warning)
	-- Soft Mint: #eaf0e5 (strings/neutral)
	-- Soft Blue: #e3ecf6 (cool neutral)
	-- Silver: #c0c0c0 (text)
	-- Light Gray: #d5d5d5 (highlight text)
	-- Slate-gray: #8996a3 (comments)
	-- Gray: #808080 (ui elements)
	-- Dark Gray: #1e1e1e (panels)

	-- Base Colors
	bg = "#09090b",
	fg = "#ffffff",   -- Pure White (Requested for normal text)
	fg_dark = "#808080", -- Gray

	-- UI Elements
	activity_bg = "#09090b",
	side_bar_bg = "#09090b", -- Night Black (seamless)
	tab_active_bg = "#1e1e1e", -- Dark Gray
	tab_inactive_bg = "#09090b",

	-- Status Line
	status_bg = "#09090b",
	status_fg = "#ffffff", -- Pure White

	-- Editor UI
	cursor_fg = "#3fb6a6",          -- Teal Accent
	line_number_fg = "#4a4a4a",     -- Dimmed Gray
	line_number_active_fg = "#6eafad", -- Sea Green
	selection_bg = "#254147",       -- Deep Teal/Slate (High visibility)
	selection_fg = "#d5d5d5",       -- Light Gray
	bracket_match_bg = "#1e1e1e",
	bracket_match_border = "#6eafad", -- Sea Green
	indent_guide_bg = "#151515",
	indent_guide_active_bg = "#3fb6a6",

	-- Git (Mapped to Chartreuse/Teal/Red)
	git_added = "#3fb6a6", -- Teal Accent
	git_modified = "#dfff00", -- Chartreuse
	git_deleted = "#e06c75", -- Soft Red (kept standard for semantic safety)
	diff_added = "#3fb6a6",
	diff_removed = "#e06c75",

	-- Git Decorations
	git_decoration_added = "#3fb6a6",
	git_decoration_modified = "#dfff00",
	git_decoration_deleted = "#e06c75",
	git_decoration_untracked = "#6eafad",
	git_decoration_ignored = "#808080",
	git_decoration_conflicting = "#dfff00",
	git_decoration_submodule = "#8996a3",

	-- Terminal Colors
	term_black = "#09090b",
	term_red = "#e06c75",
	term_green = "#3fb6a6",
	term_yellow = "#dfff00", -- Chartreuse
	term_blue = "#6eafad",
	term_magenta = "#e3ecf6", -- Soft Blue
	term_cyan = "#8996a3",
	term_white = "#c0c0c0",
	term_bright_black = "#808080",
	term_bright_red = "#e06c75",
	term_bright_green = "#eaf0e5", -- Soft Mint
	term_bright_yellow = "#dfff00",
	term_bright_blue = "#6eafad",
	term_bright_magenta = "#e3ecf6",
	term_bright_cyan = "#eaf0e5",
	term_bright_white = "#ffffff",

	-- Syntax Highlighting
	comment = "#8996a3",       -- Slate-gray
	string = "#eaf0e5",        -- Soft Mint
	string_escape = "#6eafad", -- Sea Green
	number = "#3fb6a6",        -- Teal Accent
	constant_builtin = "#3fb6a6", -- Teal Accent
	constant_user = "#dfff00", -- Chartreuse
	variable = "#e3ecf6",      -- Soft Blue
	keyword = "#6eafad",       -- Sea Green (Primary brand color)
	storage = "#3fb6a6",       -- Teal Accent
	storage_type = "#8996a3",  -- Slate-gray
	class_name = "#eaf0e5",    -- Soft Mint
	function_name = "#d5d5d5", -- Light Gray (High readability)
	variable_start = "#6eafad",
	embedded = "#6eafad",
	tag = "#6eafad",        -- Sea Green
	tag_start_end = "#808080",
	tag_attribute = "#dfff00", -- Chartreuse
	library_function = "#3fb6a6",
	library_constant = "#dfff00",
	library_type = "#8996a3",
	this_keyword = "#3fb6a6",
	zig_builtin_fn = "#dfff00", -- Chartreuse
	invalid = "#e06c75",
	json_key = "#6eafad",
	markdown_heading = "#eaf0e5",
	markdown_link = "#3fb6a6",
	markdown_list = "#dfff00",
	markdown_italic = "#8996a3",
	punctuation = "#808080", -- Gray
	operators = "#6eafad", -- Sea Green
	property = "#c0c0c0",  -- Silver
	parameter = "#c0c0c0", -- Silver
	private_property = "#808080",
	control_flow = "#dfff00", -- Chartreuse (Pop for flow control)

	-- Misc
	bracket_fg_1 = "#6eafad",
	bracket_fg_2 = "#3fb6a6",
	bracket_fg_3 = "#dfff00",
	bracket_unexpected = "#e06c75",

	-- Theme UI consistency
	title_active_bg = "#09090b",
	title_active_fg = "#dfff00", -- Chartreuse (Pop)
	tab_active_fg = "#d5d5d5",
	tab_inactive_fg = "#808080",
	sidebar_title_fg = "#c0c0c0",
	activity_badge_bg = "#3fb6a6",
	activity_fg = "#09090b",
	activity_inactive_fg = "#808080",
	sidebar_section_header_bg = "#09090b",
	panel_bg = "#09090b",
	panel_border = "#1e1e1e",
	zig_string = "#eaf0e5", -- Soft Mint
}

return M
