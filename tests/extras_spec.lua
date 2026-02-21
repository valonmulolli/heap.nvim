describe("Heap extras", function()
	local required_files = {
		"extras/fzf/heap.sh",
		"extras/fzf/heap-dark.sh",
		"extras/ghostty/heap.conf",
		"extras/ghostty/heap-dark.conf",
		"extras/kitty/heap.conf",
		"extras/kitty/heap-dark.conf",
		"extras/lazygit/heap.yml",
		"extras/lazygit/heap-dark.yml",
		"extras/yazi/heap.toml",
		"extras/yazi/heap-dark.toml",
	}

	it("contains expected extra theme files", function()
		for _, file in ipairs(required_files) do
			local stat = vim.uv.fs_stat(file)
			assert.is_truthy(stat, "Missing extras file: " .. file)
		end
	end)

	it("does not include wezterm extras", function()
		local stat = vim.uv.fs_stat("extras/wezterm")
		assert.is_nil(stat)
	end)
end)
