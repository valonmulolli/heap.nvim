local utils = require("heap.utils")

local function fresh_opts(overrides)
	local opts = {
		auto = true,
		cache = true,
		plugins = {
			telescope = true,
			blink = true,
			gitsigns = true,
			mini = true,
		},
	}
	if overrides then
		opts = vim.tbl_deep_extend("force", opts, overrides)
	end
	return opts
end

describe("Heap utils", function()
	before_each(function()
		package.loaded.lazy = nil
		package.loaded["lazy.core.config"] = nil
		_G.MiniDeps = nil
		utils.cache.clear()
	end)

	it("cache read/write roundtrip works", function()
		local key = "roundtrip-spec"
		vim.uv.fs_unlink(utils.cache.file(key))
		utils.cache.write(key, { ok = true, value = 42 })
		local cached = utils.cache.read(key)
		assert.is_truthy(cached)
		assert.is_true(cached.ok)
		assert.are.same(42, cached.value)
		vim.uv.fs_unlink(utils.cache.file(key))
	end)

	it("manual mode keeps plugin toggles", function()
		local resolved = utils.resolve_plugins(fresh_opts({
			auto = false,
			plugins = { telescope = true, gitsigns = false },
		}))
		assert.are.same("manual", resolved.source)
		assert.is_true(resolved.plugins.telescope)
		assert.is_false(resolved.plugins.gitsigns)
	end)

	it("auto mode disables plugin toggles when no manager is available", function()
		local resolved = utils.resolve_plugins(fresh_opts())
		assert.is_false(resolved.manager_available)
		assert.is_false(resolved.plugins.telescope)
		assert.is_false(resolved.plugins.blink)
		assert.is_false(resolved.plugins.gitsigns)
	end)

	it("detects lazy.nvim plugins", function()
		package.loaded.lazy = true
		package.loaded["lazy.core.config"] = {
			plugins = {
				["telescope.nvim"] = { name = "telescope.nvim" },
				["blink.cmp"] = { name = "blink.cmp" },
			},
		}

		local resolved = utils.resolve_plugins(fresh_opts())
		assert.is_true(resolved.manager_available)
		assert.is_true(resolved.plugins.telescope)
		assert.is_true(resolved.plugins.blink)
		assert.is_false(resolved.plugins.gitsigns)
	end)

	it("uses cached plugin resolution when cache is valid", function()
		package.loaded.lazy = true
		package.loaded["lazy.core.config"] = {
			plugins = {
				["telescope.nvim"] = { name = "telescope.nvim" },
			},
		}

		local first = utils.resolve_plugins(fresh_opts())
		local second = utils.resolve_plugins(fresh_opts())

		assert.are.same("detected", first.source)
		assert.are.same("cache", second.source)
		assert.is_true(second.plugins.telescope)
	end)
end)
