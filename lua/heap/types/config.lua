---@class heap.UIOptions
---@field enable_end_of_buffer? boolean
---@field disable_undercurl? boolean

---@class heap.Config
---@field variant? 'default'|'dark'
---@field transparent? boolean
---@field transparent_background? boolean
---@field forced_non_transparent? boolean
---@field cursorline? boolean
---@field auto? boolean
---@field cache? boolean
---@field plugins? table<string, boolean>
---@field tweak_background? table<string, string>
---@field tweak_syntax? table<string, string>
---@field tweak_ui? heap.UIOptions
---@field tweak_highlight? table<string, vim.api.keyset.highlight>

return {}
