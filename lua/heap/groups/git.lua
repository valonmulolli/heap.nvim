-- Highlight group: git
local highlight_utils = require("heap.highlight_utils")

local M = {}

M.apply_git_highlights = function(colors, opts)
	if opts.plugins and opts.plugins.gitsigns == false then
		return
	end

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

function M.apply(colors, opts)
	M.apply_git_highlights(colors, opts)
end

return M
