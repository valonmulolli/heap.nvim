-- Lualine theme for Heap Dark
local colors = require("heap.colors").dark_colors

local white = "#ffffff"
local black = "#09090b"
local bar_bg = colors.status_bg

local theme = {
	normal = {
		a = { bg = colors.keyword, fg = white, gui = "bold" },
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
		a = { bg = colors.fg, fg = black, gui = "bold" },
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
theme.insert.y = { bg = theme.insert.b.bg, fg = theme.insert.b.fg }
theme.visual.z = { bg = theme.visual.a.bg, fg = theme.visual.a.fg, gui = "bold" }
theme.visual.y = { bg = theme.visual.b.bg, fg = theme.visual.b.fg }
theme.replace.z = { bg = theme.replace.a.bg, fg = theme.replace.a.fg, gui = "bold" }
theme.replace.y = { bg = theme.replace.b.bg, fg = theme.replace.b.fg }
theme.command.z = { bg = theme.command.a.bg, fg = theme.command.a.fg, gui = "bold" }
theme.command.y = { bg = theme.command.b.bg, fg = theme.command.b.fg }

return theme
