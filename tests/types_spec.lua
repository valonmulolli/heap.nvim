describe("Heap types", function()
	it("can require every file in lua/heap/types", function()
		local files = vim.split(vim.fn.glob("lua/heap/types/*.lua"), "\n")

		for _, file in ipairs(files) do
			local name = vim.fn.fnamemodify(file, ":t:r")
			local ok, mod = pcall(require, "heap.types." .. name)

			assert.is_true(ok, "Failed requiring heap.types." .. name)
			assert.is_table(mod)
		end
	end)
end)
