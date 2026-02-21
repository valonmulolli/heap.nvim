local config = require("heap.config")
local groups = require("heap.groups")

local M = {}

local function get_palette_module(variant)
	if variant == "dark" then
		return "heap.palette.dark"
	end
	return "heap.palette.default"
end

---@param opts table|nil
---@return table
function M.get_palette(opts)
	local options = opts or config.options
	local palette = require(get_palette_module(options.variant))
	return config.apply_syntax_customizations(palette, options)
end

local function reset_colorscheme_state(opts)
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.o.background = "dark"
	vim.g.colors_name = opts.variant == "dark" and "heap-dark" or "heap"
end

function M.set_highlights()
	local opts = config.options
	local final_colors = M.get_palette(opts)
	local loaded_groups, resolved_opts, resolved_plugins = groups.setup(final_colors, opts)
	M.colors = final_colors
	M.options = opts
	M.runtime_options = resolved_opts
	M.loaded_groups = loaded_groups
	M.plugin_resolution = resolved_plugins
end

---@param opts table|nil
function M.load(opts)
	if opts ~= nil then
		local merged = vim.tbl_deep_extend("force", config.options, opts)
		if opts.forced_non_transparent == nil then
			merged.forced_non_transparent = nil
		end
		config.setup(merged)
	end

	reset_colorscheme_state(config.options)
	M.set_highlights()
end

---@param opts table|nil
function M.setup(opts)
	config.setup(opts)
	M.load()
end

return M
