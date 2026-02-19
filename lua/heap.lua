-- Heap for Neovim
-- Author: Generated from VS Code heap-theme-color-theme.json
-- Description: A dark theme based on the Heap VS Code theme

local M = {}
local colors = require("heap.colors")
local highlights = require("heap.highlights")
local config = require("heap.config")

-- Set highlights for editor UI elements
M.set_highlights = function()
	local opts = M.options or config.default_options

	-- Select palette based on variant
	local palette = colors.default_colors
	if opts.variant == "dark" then
		palette = colors.dark_colors
	end

	-- Apply syntax customizations to colors
	local final_colors = config.apply_syntax_customizations(palette, opts)

	-- Apply all highlights
	highlights.apply_all_highlights(final_colors, opts)

	-- Store the colors for external access
	M.colors = final_colors
end

M.setup = function(opts)
	config.validate_options(opts)
	local forced_non_transparent_specified = opts and opts.forced_non_transparent ~= nil or false

	-- 1. Determine current options state (if any)
	local current_opts = M.options or {}

	-- 2. Deep merge NEW opts over CURRENT opts, then merge into defaults.
	local merged_user_opts = vim.tbl_deep_extend("force", current_opts, opts or {})
	opts = config.merge_options(merged_user_opts)

	-- Apply variant-specific defaults
	if opts.variant == "dark" then
		-- Heap Dark defaults to non-transparent for richness, unless explicitly disabled
		if not forced_non_transparent_specified and opts.transparent == false then
			opts.forced_non_transparent = true
		end
	elseif not forced_non_transparent_specified then
		opts.forced_non_transparent = false
	end

	-- Initialize Neovim state for the colorscheme
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.background = "dark"
	vim.g.colors_name = opts.variant == "dark" and "heap-dark" or "heap"

	-- Apply options
	M.options = opts

	-- Apply highlight definitions
	M.set_highlights()
end

return M
