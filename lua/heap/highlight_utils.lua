-- Highlight utility functions for the Heap theme
local M = {}

---@param opts heap.Config|nil
---@return boolean
local function is_transparent(opts)
	opts = opts or {}
	if opts.forced_non_transparent == true then
		return false
	end
	return opts.transparent == true or opts.transparent_background == true
end

-- Function to get background based on transparency options.
---@param opts heap.Config|nil
---@return fun(default_bg:string|nil):string|nil
M.get_background_func = function(opts)
	if is_transparent(opts) then
		return function(_)
			return nil
		end
	end

	return function(default_bg)
		return default_bg or nil
	end
end

-- Function to get background with optional `tweak_background` override.
---@param opts heap.Config|nil
---@param element_type string
---@param default_bg string|nil
---@return string|nil
M.get_custom_bg = function(opts, element_type, default_bg)
	opts = opts or {}

	local custom_bg = opts.tweak_background and opts.tweak_background[element_type]
	if custom_bg == nil then
		return M.get_background_func(opts)(default_bg)
	end

	if custom_bg == "none" then
		-- If forced_non_transparent is true, keep actual backgrounds (except menu).
		if opts.forced_non_transparent and element_type ~= "menu" then
			return default_bg
		end
		return nil
	end

	return custom_bg
end

-- Determine if undercurl is enabled.
---@param opts heap.Config|nil
---@return boolean
M.is_undercurl_enabled = function(opts)
	opts = opts or {}
	return not (opts.tweak_ui and opts.tweak_ui.disable_undercurl)
end

return M
