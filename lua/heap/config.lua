-- Configuration module for the Heap theme
local M = {}

-- Default configuration options
M.default_options = {
	variant = "default", -- "default" or "dark"
	transparent = false,
	transparent_background = false,
	forced_non_transparent = false,
	cursorline = true,
	sidebars = {},
	plugins = {
		telescope = true,
		which_key = true,
		dashboard = true,
		indent_blankline = true,
		neo_tree = true,
		trouble = true,
		noice = true,
		mini = true,
		flash = true,
		blink = true,
		gitsigns = true,
		lazy = true,
		mason = true,
		snacks = true,
	},

	-- Advanced customization options
	tweak_background = {},
	tweak_syntax = {},
	tweak_ui = {},
	tweak_highlight = {},
}

-- Merge custom configuration with defaults
M.merge_options = function(user_opts)
	-- Deep copy helper
	local function deep_copy(t)
		if type(t) ~= 'table' then return t end
		local copy = {}
		for k, v in pairs(t) do
			copy[k] = deep_copy(v)
		end
		return copy
	end

	-- Deep merge helper
	local function deep_merge(target, source)
		for k, v in pairs(source) do
			if type(v) == "table" and type(target[k]) == "table" then
				deep_merge(target[k], v)
			else
				target[k] = v
			end
		end
		return target
	end

	-- 1. Start with a fresh deep copy of defaults
	local options = deep_copy(M.default_options)

	-- 2. Deep merge user options if they exist
	if user_opts and type(user_opts) == "table" then
		deep_merge(options, user_opts)
	end

	return options
end

-- Apply syntax customizations to colors
M.apply_syntax_customizations = function(original_colors, opts)
	-- Validate inputs
	if not original_colors or type(original_colors) ~= "table" then
		error("heap.config.apply_syntax_customizations: original_colors must be a table")
	end
	if not opts or type(opts) ~= "table" then
		error("heap.config.apply_syntax_customizations: opts must be a table")
	end

	local colors = {}

	-- Copy original colors
	for k, v in pairs(original_colors) do
		colors[k] = v
	end

	-- Apply syntax customizations if provided
	if opts.tweak_syntax then
		if type(opts.tweak_syntax) ~= "table" then
			error("heap.config.apply_syntax_customizations: opts.tweak_syntax must be a table")
		end

		for syntax_name, custom_color in pairs(opts.tweak_syntax) do
			-- Validate key and value types
			if type(syntax_name) ~= "string" then
				error("heap.config.apply_syntax_customizations: syntax names must be strings")
			end
			if custom_color ~= "default" and original_colors[syntax_name] then
				colors[syntax_name] = custom_color
			end
		end
	end

	return colors
end

return M
