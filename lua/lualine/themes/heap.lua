-- Lualine theme for Heap (default variant)
local colors = require("heap.colors").default_colors

local white = "#ffffff"
local black = "#0a0a0a"
local bar_bg = colors.status_bg

local theme = {
	normal = {
		a = { bg = colors.keyword, fg = black, gui = "bold" },
		b = { bg = colors.tab_active_bg, fg = colors.fg },
		c = { bg = bar_bg, fg = colors.status_fg or colors.fg },
	},
	insert = {
		a = { bg = colors.term_blue, fg = white, gui = "bold" },
		b = { bg = colors.tab_active_bg, fg = colors.fg },
		c = { bg = bar_bg, fg = colors.fg },
	},
	visual = {
		a = { bg = colors.term_yellow, fg = black, gui = "bold" },
		b = { bg = colors.tab_active_bg, fg = colors.fg },
		c = { bg = bar_bg, fg = colors.fg },
	},
	replace = {
		a = { bg = colors.term_red, fg = white, gui = "bold" },
		b = { bg = colors.tab_active_bg, fg = colors.fg },
		c = { bg = bar_bg, fg = colors.fg },
	},
	command = {
		a = { bg = colors.tag_attribute, fg = black, gui = "bold" },
		b = { bg = colors.tab_active_bg, fg = colors.fg },
		c = { bg = bar_bg, fg = colors.fg },
	},
	inactive = {
		a = { bg = bar_bg, fg = colors.fg_dark },
		b = { bg = bar_bg, fg = colors.fg_dark },
		c = { bg = bar_bg, fg = colors.fg_dark },
	},
}

theme.normal.z = { bg = theme.normal.a.bg, fg = theme.normal.a.fg, gui = "bold" }
theme.normal.y = { bg = theme.normal.b.bg, fg = theme.normal.b.fg }
theme.insert.z = { bg = theme.insert.a.bg, fg = theme.insert.a.fg, gui = "bold" }
theme.visual.z = { bg = theme.visual.a.bg, fg = theme.visual.a.fg, gui = "bold" }
theme.replace.z = { bg = theme.replace.a.bg, fg = theme.replace.a.fg, gui = "bold" }
theme.command.z = { bg = theme.command.a.bg, fg = theme.command.a.fg, gui = "bold" }

return theme
