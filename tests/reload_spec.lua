describe("Heap reload", function()
	it("preserves the active configuration when clearing the cache", function()
		local heap = require("heap")
		heap.setup({ variant = "dark", transparent = true, auto = false })

		require("heap.utils").reload()

		local reloaded = require("heap")
		local options = require("heap.config").options
		assert.are.same("heap-dark", vim.g.colors_name)
		assert.are.same("dark", options.variant)
		assert.is_true(options.transparent)
		assert.is_nil(vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg)
		assert.is_not_nil(reloaded.colors)
	end)
end)
