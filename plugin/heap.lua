-- plugin/heap.lua
-- This file makes heap a proper Neovim plugin

if vim.g.loaded_heap then
	return
end
vim.g.loaded_heap = true

-- Add documentation for the plugin
-- This helps with the `:help heap` command
-- More documentation can be added in doc/heap.txt

-- Add the color scheme to Neovim's recognized schemes
vim.api.nvim_create_user_command("Heap", function()
	require("heap").load()
end, {
	desc = "Load Heap theme",
})

vim.api.nvim_create_user_command("HeapFetch", function()
	require("heap.utils").reload()
end, {
	desc = "Clear Heap cache and reload colorscheme",
})
