local highlight_utils = require("heap.highlight_utils")

describe("Heap highlight utils", function()
	it("returns nil background when transparent is enabled", function()
		local get_bg = highlight_utils.get_background_func({ transparent = true })
		assert.is_nil(get_bg("#101010"))
	end)

	it("uses transparent_background as backward-compatible fallback", function()
		local get_bg = highlight_utils.get_background_func({ transparent_background = true })
		assert.is_nil(get_bg("#101010"))
	end)

	it("returns default background when transparent is disabled", function()
		local get_bg = highlight_utils.get_background_func({ transparent = false })
		assert.are.same("#101010", get_bg("#101010"))
	end)

	it("forced_non_transparent overrides transparent mode", function()
		local get_bg = highlight_utils.get_background_func({
			transparent = true,
			forced_non_transparent = true,
		})
		assert.are.same("#101010", get_bg("#101010"))
	end)

	it("resolves custom background values", function()
		local bg = highlight_utils.get_custom_bg({
			tweak_background = { telescope = "#1a1a1a" },
		}, "telescope", "#101010")
		assert.are.same("#1a1a1a", bg)
	end)

	it("maps custom none to nil background", function()
		local bg = highlight_utils.get_custom_bg({
			tweak_background = { normal = "none" },
		}, "normal", "#101010")
		assert.is_nil(bg)
	end)

	it("keeps menu none transparent even when forced non-transparent", function()
		local bg = highlight_utils.get_custom_bg({
			forced_non_transparent = true,
			tweak_background = { menu = "none" },
		}, "menu", "#101010")
		assert.is_nil(bg)
	end)

	it("replaces none with default bg when forced non-transparent", function()
		local bg = highlight_utils.get_custom_bg({
			forced_non_transparent = true,
			tweak_background = { normal = "none" },
		}, "normal", "#101010")
		assert.are.same("#101010", bg)
	end)

	it("enables undercurl by default", function()
		assert.is_true(highlight_utils.is_undercurl_enabled({}))
	end)

	it("disables undercurl when tweak_ui.disable_undercurl is true", function()
		assert.is_false(highlight_utils.is_undercurl_enabled({
			tweak_ui = { disable_undercurl = true },
		}))
	end)
end)
