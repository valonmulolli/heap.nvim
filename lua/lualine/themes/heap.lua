-- Dynamic Lualine theme for Heap
-- This theme automatically adapts based on whether heap or heap-dark is active

local function get_theme()
  local heap = require('heap')
  local colors_mod = require('heap.colors')
  
  -- Robust Variant Detection
  local is_dark = (vim.g.colors_name == "heap-dark")
  
  -- If we can't tell from the name, check the core options if loaded
  if not is_dark and heap.options and heap.options.variant == "dark" then
    is_dark = true
  end
  
  -- Select palette
  local colors = is_dark and colors_mod.dark_colors or colors_mod.default_colors
  
  local white = "#ffffff"
  local black = is_dark and "#09090b" or "#0a0a0a"
  local bar_bg = colors.status_bg

  -- Theme structure
  -- We use the 'keyword' color for Normal mode which is:
  -- #6eafad (Sea Green) for Heap-Dark
  -- #aadadb (Teal) for Heap Default
  local theme = {
    normal = {
      a = { bg = colors.keyword, fg = is_dark and white or black, gui = 'bold' },
      b = { bg = colors.tab_active_bg, fg = colors.fg },
      c = { bg = bar_bg, fg = colors.status_fg or colors.fg },
    },
    insert = {
      a = { bg = is_dark and colors.git_added or colors.term_blue, fg = white, gui = 'bold' },
      b = { bg = colors.tab_active_bg, fg = colors.fg },
      c = { bg = bar_bg, fg = colors.fg },
    },
    visual = {
      a = { bg = colors.term_yellow, fg = black, gui = 'bold' },
      b = { bg = colors.tab_active_bg, fg = colors.fg },
      c = { bg = bar_bg, fg = colors.fg },
    },
    replace = {
      a = { bg = colors.term_red, fg = white, gui = 'bold' },
      b = { bg = colors.tab_active_bg, fg = colors.fg },
      c = { bg = bar_bg, fg = colors.fg },
    },
    command = {
      a = { bg = is_dark and colors.fg or colors.tag_attribute, fg = black, gui = 'bold' },
      b = { bg = colors.tab_active_bg, fg = colors.fg },
      c = { bg = bar_bg, fg = colors.fg },
    },
    inactive = {
      a = { bg = bar_bg, fg = colors.fg_dark },
      b = { bg = bar_bg, fg = colors.fg_dark },
      c = { bg = bar_bg, fg = colors.fg_dark },
    },
  }

  -- Mirror right segments for "Perfect" look
  theme.normal.z = { bg = theme.normal.a.bg, fg = theme.normal.a.fg, gui = 'bold' }
  theme.normal.y = { bg = theme.normal.b.bg, fg = theme.normal.b.fg }
  theme.insert.z = { bg = theme.insert.a.bg, fg = theme.insert.a.fg, gui = 'bold' }
  theme.visual.z = { bg = theme.visual.a.bg, fg = theme.visual.a.fg, gui = 'bold' }
  theme.replace.z = { bg = theme.replace.a.bg, fg = theme.replace.a.fg, gui = 'bold' }
  theme.command.z = { bg = theme.command.a.bg, fg = theme.command.a.fg, gui = 'bold' }

  return theme
end

return get_theme()