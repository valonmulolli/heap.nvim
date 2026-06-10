-- plugin/heap.lua

if vim.g.loaded_heap then
	return
end
vim.g.loaded_heap = true

local heap_augroup = vim.api.nvim_create_augroup("heap", { clear = true })

-- Re-apply heap highlights after all other ColorScheme handlers have run.
-- Some plugins register ColorScheme autocommands that override heap's colors;
-- vim.schedule defers re-application to the next event loop iteration so
-- heap always wins.
vim.api.nvim_create_autocmd("ColorScheme", {
	group = heap_augroup,
	pattern = { "heap", "heap-dark" },
	callback = function()
		vim.schedule(function()
			require("heap.init").set_highlights()
		end)
	end,
})

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
