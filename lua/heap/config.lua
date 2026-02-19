-- Configuration module for the Heap theme
local M = {}

-- Default configuration options
M.default_options = {
	variant = "default", -- "default" or "dark"
	transparent = false,
	transparent_background = false,
	cursorline = true,
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
		notify = true,
		render_markdown = true,
		fzf_lua = true,
		oil = true,
		harpoon = true,
		nvim_tree = true,
		bufferline = true,
	},

	-- Advanced customization options
	tweak_background = {},
	tweak_syntax = {},
	tweak_ui = {},
	tweak_highlight = {},
}

local function assert_table_or_nil(value, name)
	if value ~= nil and type(value) ~= "table" then
		error("heap.setup: `" .. name .. "` must be a table")
	end
end

local function assert_boolean_or_nil(value, name)
	if value ~= nil and type(value) ~= "boolean" then
		error("heap.setup: `" .. name .. "` must be a boolean")
	end
end

-- Validate user options before merge/apply.
M.validate_options = function(user_opts)
	if user_opts == nil then
		return
	end
	if type(user_opts) ~= "table" then
		error("heap.setup: options must be a table or nil")
	end

	if user_opts.variant ~= nil and user_opts.variant ~= "default" and user_opts.variant ~= "dark" then
		error("heap.setup: `variant` must be \"default\" or \"dark\"")
	end

	assert_boolean_or_nil(user_opts.transparent, "transparent")
	assert_boolean_or_nil(user_opts.transparent_background, "transparent_background")
	assert_boolean_or_nil(user_opts.forced_non_transparent, "forced_non_transparent")
	assert_boolean_or_nil(user_opts.cursorline, "cursorline")

	assert_table_or_nil(user_opts.tweak_background, "tweak_background")
	assert_table_or_nil(user_opts.tweak_syntax, "tweak_syntax")
	assert_table_or_nil(user_opts.tweak_ui, "tweak_ui")
	assert_table_or_nil(user_opts.tweak_highlight, "tweak_highlight")

	if user_opts.plugins ~= nil then
		if type(user_opts.plugins) ~= "table" then
			error("heap.setup: `plugins` must be a table")
		end
		for plugin_name, enabled in pairs(user_opts.plugins) do
			if type(plugin_name) ~= "string" then
				error("heap.setup: plugin names must be strings")
			end
			if type(enabled) ~= "boolean" then
				error("heap.setup: plugin `" .. plugin_name .. "` must be a boolean")
			end
		end
	end
end

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
