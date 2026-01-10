-- Highlight utility functions for the Heap theme
local M = {}

-- Function to get background based on transparency options
M.get_background_func = function(opts)
  -- Use the simplified transparent option as primary, with fallback to transparent_background for backward compatibility
  -- If forced_non_transparent is true, override all transparency settings
  local forced_non_transparent = opts.forced_non_transparent or false
  local transparent = forced_non_transparent and false or (opts.transparent or opts.transparent_background)
  if transparent then
    return function(default_bg) return nil end
  else
    return function(default_bg) return default_bg or nil end
  end
end

-- Function to get background with possible customization
M.get_custom_bg = function(opts, element_type, default_bg)
  local get_bg = M.get_background_func(opts)
  local custom_bg = opts.tweak_background and opts.tweak_background[element_type]
  if custom_bg ~= nil then
    -- If forced_non_transparent is true, override any "none" settings except for menu
    if opts.forced_non_transparent and custom_bg == "none" and element_type ~= "menu" then
      return default_bg
    end
    return custom_bg == "none" and nil or custom_bg
  else
    return get_bg(default_bg)
  end
end

-- Determine if undercurl is enabled
M.is_undercurl_enabled = function(opts)
  local undercurl_enabled = not opts.tweak_ui or not opts.tweak_ui.disable_undercurl
  return undercurl_enabled
end

return M