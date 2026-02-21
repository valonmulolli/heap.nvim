-- Highlight group: nvim-tree
local highlight_utils = require("heap.highlight_utils")

local M = {}

M.apply_nvim_tree_highlights = function(colors, opts)
	if opts.plugins and opts.plugins.nvim_tree == false then
		return
	end

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
	vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = colors.term_cyan, bold = true })

	if opts.plugins and opts.plugins.nvim_tree then
		vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = colors.term_cyan })
		vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = colors.fg_dark })
		vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = colors.keyword })
		vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = colors.term_green })
	end
end

-- Apply bufferline highlights

function M.apply(colors, opts)
	M.apply_nvim_tree_highlights(colors, opts)
end

return M
