-- Heap for Neovim
-- Author: Generated from VS Code heap-theme-color-theme.json
-- Description: A dark theme based on the Heap VS Code theme

local M = {}
local colors = require("heap.colors")
local highlights = require("heap.highlights")
local config = require("heap.config")
local highlight_utils = require("heap.highlight_utils")

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
	-- Validate and merge options
	if opts and type(opts) ~= "table" then
		error("heap.setup: options must be a table or nil")
	end

	-- 1. Determine current options state (if any)
	local current_opts = M.options or {}
	
	-- 2. Deep merge: NEW opts override CURRENT opts which override DEFAULTS
	-- This behavior is achieved by merge_options returning a fresh copy starting from defaults,
	-- so we apply it twice or smartly.
	
	-- First, merge CURRENT user-set options into defaults
	local base_opts = config.merge_options(current_opts)
	
	-- Then, merge the NEW setup(opts) call into those base options
	-- We do this manually because config.merge_options always starts from M.default_options
	if opts then
		for k, v in pairs(opts) do
			if type(v) == "table" and type(base_opts[k]) == "table" then
				for sub_k, sub_v in pairs(v) do
					base_opts[k][sub_k] = sub_v
				end
			else
				base_opts[k] = v
			end
		end
	end

	opts = base_opts

	-- Apply variant-specific defaults
	if opts.variant == "dark" then
		-- Heap Dark defaults to non-transparent for richness, unless explicitly disabled
		if opts.forced_non_transparent == nil and opts.transparent == false then
			opts.forced_non_transparent = true
		end
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
