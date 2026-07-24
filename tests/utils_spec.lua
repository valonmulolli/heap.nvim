local utils = require("heap.utils")

local function fresh_opts(overrides)
	local opts = {
		auto = true,
		cache = true,
		plugins = {
			telescope = true,
			blink = true,
			nvim_cmp = true,
			gitsigns = true,
			mini = true,
		},
	}
	if overrides then
		opts = vim.tbl_deep_extend("force", opts, overrides)
	end
	return opts
end

local function with_pack_entries(entries, callback)
	local original_pack = vim.pack
	vim.pack = {
		get = function()
			return entries
		end,
	}
	local ok, result = pcall(callback)
	vim.pack = original_pack
	assert.is_true(ok, result)
	return result
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

	it("auto mode disables plugin toggles when no plugins are installed", function()
		local resolved = with_pack_entries({}, function()
			return utils.resolve_plugins(fresh_opts({ cache = false }))
		end)
		assert.is_false(resolved.plugins.telescope)
		assert.is_false(resolved.plugins.blink)
		assert.is_false(resolved.plugins.gitsigns)
		assert.is_false(resolved.plugins.nvim_cmp)
	end)

	it("detects lazy.nvim plugins", function()
		local resolved = with_pack_entries({}, function()
			package.loaded.lazy = true
			package.loaded["lazy.core.config"] = {
				plugins = {
					["telescope.nvim"] = { name = "telescope.nvim" },
					["blink.cmp"] = { name = "blink.cmp" },
				},
			}

			return utils.resolve_plugins(fresh_opts({ cache = false }))
		end)
		assert.is_true(resolved.manager_available)
		assert.is_true(resolved.plugins.telescope)
		assert.is_true(resolved.plugins.blink)
		assert.is_false(resolved.plugins.gitsigns)
	end)

	it("uses cached plugin resolution when cache is valid", function()
		local results = with_pack_entries({}, function()
			package.loaded.lazy = true
			package.loaded["lazy.core.config"] = {
				plugins = {
					["telescope.nvim"] = { name = "telescope.nvim" },
				},
			}

			local detected = utils.resolve_plugins(fresh_opts())
			local cached = utils.resolve_plugins(fresh_opts())
			return { detected, cached }
		end)
		local first, second = results[1], results[2]

		assert.are.same("detected", first.source)
		assert.are.same("cache", second.source)
		assert.is_true(second.plugins.telescope)
	end)

	it("detects inactive vim.pack packages", function()
		local resolved = with_pack_entries({
			{ active = false, spec = { name = "telescope.nvim" } },
		}, function()
			return utils.resolve_plugins(fresh_opts({ cache = false }))
		end)

		assert.is_true(resolved.plugins.telescope)
	end)

	it("ignores malformed cache payloads", function()
		utils.write(utils.cache.file("plugins"), "42")
		local resolved = with_pack_entries({}, function()
			return utils.resolve_plugins(fresh_opts())
		end)

		assert.are.same("detected", resolved.source)
	end)
end)
