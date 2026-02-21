local M = {}
local utils = require("heap.utils")

M.core_order = {
	"base",
	"syntax",
	"treesitter",
	"lsp",
}

M.order = {
	"base",
	"syntax",
	"treesitter",
	"lsp",
	"git",
	"completion",
	"telescope",
	"nvim_tree",
	"bufferline",
	"plugins",
	"custom",
}

---@param colors table
---@param opts table
---@return table loaded
---@return table resolved_opts
---@return table resolved_plugins
function M.setup(colors, opts)
	local loaded = {}
	local resolved_opts = vim.deepcopy(opts)
	local resolved_plugins = utils.resolve_plugins(opts)
	resolved_opts.plugins = resolved_plugins.plugins

	for _, name in ipairs(M.core_order) do
		require("heap.groups." .. name).apply(colors, resolved_opts)
		loaded[name] = true
	end

	if resolved_opts.plugins.gitsigns then
		require("heap.groups.git").apply(colors, resolved_opts)
		loaded.git = true
	end

	if resolved_opts.plugins.blink then
		require("heap.groups.completion").apply(colors, resolved_opts)
		loaded.completion = true
	end

	if resolved_opts.plugins.telescope then
		require("heap.groups.telescope").apply(colors, resolved_opts)
		loaded.telescope = true
	end

	if resolved_opts.plugins.nvim_tree then
		require("heap.groups.nvim_tree").apply(colors, resolved_opts)
		loaded.nvim_tree = true
	end

	if resolved_opts.plugins.bufferline then
		require("heap.groups.bufferline").apply(colors, resolved_opts)
		loaded.bufferline = true
	end

	require("heap.groups.plugins").apply(colors, resolved_opts)
	loaded.plugins = true

	-- Keep user overrides last so tweak_highlight always wins.
	require("heap.groups.custom").apply(colors, resolved_opts)
	loaded.custom = true

	return loaded, resolved_opts, resolved_plugins
end

return M
