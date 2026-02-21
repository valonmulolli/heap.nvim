local M = {}
M.cache = {}

M.plugin_aliases = {
	telescope = { "telescope.nvim" },
	which_key = { "which-key.nvim" },
	dashboard = { "dashboard-nvim" },
	indent_blankline = { "indent-blankline.nvim", "indent_blankline.nvim" },
	neo_tree = { "neo-tree.nvim" },
	trouble = { "trouble.nvim" },
	noice = { "noice.nvim" },
	mini = { "mini.nvim" },
	flash = { "flash.nvim" },
	blink = { "blink.cmp" },
	gitsigns = { "gitsigns.nvim" },
	lazy = { "lazy.nvim" },
	mason = { "mason.nvim" },
	snacks = { "snacks.nvim" },
	notify = { "nvim-notify", "notify.nvim" },
	render_markdown = { "render-markdown.nvim" },
	fzf_lua = { "fzf-lua" },
	oil = { "oil.nvim" },
	harpoon = { "harpoon" },
	nvim_tree = { "nvim-tree.lua" },
	bufferline = { "bufferline.nvim" },
	zignite = { "zignite.nvim" },
}

---@param path string
---@return string|nil
function M.read(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local data = file:read("*a")
	file:close()
	return data
end

---@param path string
---@param data string
function M.write(path, data)
	vim.fn.mkdir(vim.fs.dirname(path), "p")
	local file = assert(io.open(path, "w+"))
	file:write(data)
	file:close()
end

---@param key string
---@return string
function M.cache.file(key)
	return vim.fs.joinpath(vim.fn.stdpath("cache"), "heap-" .. key .. ".json")
end

---@param key string
---@return table|nil
function M.cache.read(key)
	local data = M.read(M.cache.file(key))
	if not data then
		return nil
	end

	local ok, decoded = pcall(vim.json.decode, data, { luanil = { object = true, array = true } })
	return ok and decoded or nil
end

---@param key string
---@param value table
function M.cache.write(key, value)
	pcall(M.write, M.cache.file(key), vim.json.encode(value))
end

function M.cache.clear()
	vim.uv.fs_unlink(M.cache.file("plugins"))
end

---@return table
function M.detect_installed_plugins()
	local detected = {}
	local managers = {
		lazy = false,
		vim_pack = false,
		mini_deps = false,
	}

	if package.loaded.lazy then
		local ok, lazy_config = pcall(require, "lazy.core.config")
		if ok and lazy_config and type(lazy_config.plugins) == "table" then
			managers.lazy = true
			for plugin_name, _ in pairs(lazy_config.plugins) do
				detected[plugin_name] = true
			end
		end
	end

	if vim.pack then
		local ok, packdata = pcall(vim.pack.get, nil, { info = false })
		if ok and type(packdata) == "table" then
			managers.vim_pack = true
			for _, plugin in ipairs(packdata) do
				if plugin.active and plugin.spec and plugin.spec.name then
					detected[plugin.spec.name] = true
				end
			end
		end
	end

	if _G.MiniDeps then
		local ok, session = pcall(_G.MiniDeps.get_session)
		if ok and type(session) == "table" then
			managers.mini_deps = true
			for _, plugin in ipairs(session) do
				if plugin.name then
					detected[plugin.name] = true
				end
			end
		end
	end

	local manager_available = managers.lazy or managers.vim_pack or managers.mini_deps
	return {
		plugins = detected,
		managers = managers,
		manager_available = manager_available,
	}
end

---@param detected table<string, boolean>
---@param names string[]
---@return boolean
local function has_any_alias(detected, names)
	for _, name in ipairs(names) do
		if detected[name] then
			return true
		end
	end
	return false
end

---@param detected table<string, boolean>
---@return boolean
local function has_mini_module(detected)
	for plugin_name, _ in pairs(detected) do
		if plugin_name:match("^mini%.") then
			return true
		end
	end
	return false
end

---@param opts table
---@return table
function M.resolve_plugins(opts)
	local resolved = vim.deepcopy(opts.plugins or {})
	if opts.auto == false then
		return {
			plugins = resolved,
			managers = { lazy = false, vim_pack = false, mini_deps = false },
			manager_available = true,
			source = "manual",
		}
	end

	local detected_state = M.detect_installed_plugins()
	local detected_plugins = detected_state.plugins
	local manager_available = detected_state.manager_available

	local signature_parts = {}
	for plugin_name, _ in pairs(detected_plugins) do
		table.insert(signature_parts, plugin_name)
	end
	table.sort(signature_parts)
	local signature = table.concat(signature_parts, ",")
	local cache_payload

	if opts.cache ~= false then
		cache_payload = M.cache.read("plugins")
	end

	local plugin_defaults = opts.plugins or {}
	if cache_payload
		and cache_payload.signature == signature
		and cache_payload.manager_available == manager_available
		and vim.deep_equal(cache_payload.plugin_defaults, plugin_defaults)
	then
		return {
			plugins = cache_payload.plugins,
			managers = detected_state.managers,
			manager_available = manager_available,
			source = "cache",
		}
	end

	if not manager_available then
		for plugin_name, enabled in pairs(resolved) do
			if enabled ~= false then
				resolved[plugin_name] = false
			end
		end
	else
		for plugin_name, enabled in pairs(resolved) do
			if enabled ~= false then
				local aliases = M.plugin_aliases[plugin_name] or {}
				local installed = has_any_alias(detected_plugins, aliases)
				if not installed and plugin_name == "mini" then
					installed = has_mini_module(detected_plugins)
				end
				resolved[plugin_name] = installed
			end
		end
	end

	if opts.cache ~= false then
		M.cache.write("plugins", {
			signature = signature,
			manager_available = manager_available,
			plugin_defaults = plugin_defaults,
			plugins = resolved,
		})
	end

	return {
		plugins = resolved,
		managers = detected_state.managers,
		manager_available = manager_available,
		source = "detected",
	}
end

function M.reload()
	M.cache.clear()
	for name, _ in pairs(package.loaded) do
		if name:match("^heap") then
			package.loaded[name] = nil
		end
	end
	vim.notify("Heap reloaded", vim.log.levels.WARN)
	vim.cmd("colorscheme heap")
end

return M
