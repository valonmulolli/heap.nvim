local config = require("heap.config")
local groups = require("heap.groups")
local palette = require("heap.palette.default")

describe("Heap groups", function()
	it("can require every file in lua/heap/groups", function()
		local files = vim.split(vim.fn.glob("lua/heap/groups/*.lua"), "\n")

		for _, file in ipairs(files) do
			local name = vim.fn.fnamemodify(file, ":t:r")
			local ok, mod = pcall(require, "heap.groups." .. name)

			assert.is_true(ok, "Failed requiring heap.groups." .. name)
			assert.is_table(mod)
		end
	end)

	it("applies all registered group modules", function()
		config.setup({ auto = false })
		local loaded = groups.setup(palette, config.options)

		for _, name in ipairs(groups.order) do
			assert.is_true(loaded[name], "Group did not run: " .. name)
		end
	end)

	it("respects explicit plugin disable for nvim-tree highlights", function()
		config.setup({ auto = false, plugins = { nvim_tree = false } })
		vim.cmd("colorscheme heap")

		local nvimtree_folder = vim.api.nvim_get_hl(0, { name = "NvimTreeFolderName" })
		assert.same(vim.empty_dict(), nvimtree_folder)
	end)

	it("defines zignite highlight groups when enabled", function()
		config.setup({ auto = false, plugins = { zignite = true } })
		vim.cmd("colorscheme heap")

		local border = vim.api.nvim_get_hl(0, { name = "ZigniteBorder" })
		local success = vim.api.nvim_get_hl(0, { name = "ZigniteBorderSuccess" })
		local err = vim.api.nvim_get_hl(0, { name = "ZigniteBorderError" })

		assert.is_truthy(border.fg)
		assert.is_truthy(success.fg)
		assert.is_truthy(err.fg)
	end)

	it("respects explicit plugin disable for zignite highlights", function()
		config.setup({ auto = false, plugins = { zignite = false } })
		vim.cmd("colorscheme heap")

		local border = vim.api.nvim_get_hl(0, { name = "ZigniteBorder" })
		assert.same(vim.empty_dict(), border)
	end)
end)
