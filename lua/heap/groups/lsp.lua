-- Highlight group: diagnostics / LSP
local highlight_utils = require("heap.highlight_utils")

local M = {}

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

function M.apply(colors, opts)
	M.apply_diagnostic_highlights(colors, opts)
end

return M
