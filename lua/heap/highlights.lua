-- Compatibility shim for legacy `require("heap.highlights")` imports.
local base = require("heap.groups.base")
local syntax = require("heap.groups.syntax")
local treesitter = require("heap.groups.treesitter")
local git = require("heap.groups.git")
local lsp = require("heap.groups.lsp")
local completion = require("heap.groups.completion")
local telescope = require("heap.groups.telescope")
local nvim_tree = require("heap.groups.nvim_tree")
local bufferline = require("heap.groups.bufferline")
local plugins = require("heap.groups.plugins")
local custom = require("heap.groups.custom")

local M = {}

M.apply_editor_highlights = base.apply_editor_highlights
M.apply_syntax_highlights = syntax.apply_syntax_highlights
M.apply_treesitter_highlights = treesitter.apply_treesitter_highlights
M.apply_git_highlights = git.apply_git_highlights
M.apply_diagnostic_highlights = lsp.apply_diagnostic_highlights
M.apply_completion_highlights = completion.apply_completion_highlights
M.apply_telescope_highlights = telescope.apply_telescope_highlights
M.apply_nvim_tree_highlights = nvim_tree.apply_nvim_tree_highlights
M.apply_bufferline_highlights = bufferline.apply_bufferline_highlights
M.apply_plugin_highlights = plugins.apply_plugin_highlights
M.apply_custom_highlights = custom.apply_custom_highlights
M.apply_terminal_colors = base.apply_terminal_colors

function M.apply_all_highlights(colors, opts)
	base.apply_editor_highlights(colors, opts)
	syntax.apply_syntax_highlights(colors, opts)
	treesitter.apply_treesitter_highlights(colors, opts)
	git.apply_git_highlights(colors, opts)
	lsp.apply_diagnostic_highlights(colors, opts)
	completion.apply_completion_highlights(colors, opts)
	telescope.apply_telescope_highlights(colors, opts)
	nvim_tree.apply_nvim_tree_highlights(colors, opts)
	bufferline.apply_bufferline_highlights(colors, opts)
	plugins.apply_plugin_highlights(colors, opts)
	base.apply_terminal_colors(colors)
	custom.apply_custom_highlights(opts)
end

return M
