local heap = require("heap")
local config = require("heap.config")

local default_palette = require("heap.palette.default")

describe("Heap colorscheme", function()
	before_each(function()
		config.setup()
	end)

	it("loads default variant without errors", function()
		local ok, err = pcall(vim.cmd, "colorscheme heap")

		assert.is_true(ok, "colorscheme heap failed: " .. tostring(err))
		assert.are.same("heap", vim.g.colors_name)
	end)

	it("loads dark variant without errors", function()
		local ok, err = pcall(vim.cmd, "colorscheme heap-dark")

		assert.is_true(ok, "colorscheme heap-dark failed: " .. tostring(err))
		assert.are.same("heap-dark", vim.g.colors_name)
	end)

	it("supports transparent backgrounds", function()
		heap.setup({ transparent = true })
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })

		assert.is_nil(normal.bg)
	end)

	it("resets stale tweak_syntax keys across setup calls", function()
		heap.setup({ tweak_syntax = { keyword = "#ff0000" } })
		assert.are.same("#ff0000", heap.colors.keyword)

		heap.setup({ tweak_syntax = {} })
		assert.are.same(default_palette.keyword, heap.colors.keyword)
	end)
end)
