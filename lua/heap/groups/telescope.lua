-- Highlight group: telescope
local highlight_utils = require("heap.highlight_utils")

local M = {}

M.apply_telescope_highlights = function(colors, opts)
	if opts.plugins and opts.plugins.telescope == false then
		return
	end

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

function M.apply(colors, opts)
	M.apply_telescope_highlights(colors, opts)
end

return M
