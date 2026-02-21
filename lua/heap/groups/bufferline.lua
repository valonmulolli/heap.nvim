-- Highlight group: bufferline
local highlight_utils = require("heap.highlight_utils")

local M = {}

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

function M.apply(colors, opts)
	M.apply_bufferline_highlights(colors, opts)
end

return M
