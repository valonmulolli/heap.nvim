-- Color contrast accessibility tests for the Heap theme
local heap = require('heap')

-- Function to calculate luminance from RGB
local function get_luminance(r, g, b)
  local function sRGB_to_linear(color)
    color = color / 255
    return color <= 0.03928
        and color / 12.92
        or ((color + 0.055) / 1.055) ^ 2.4
  end

  local r_lin, g_lin, b_lin = sRGB_to_linear(r), sRGB_to_linear(g), sRGB_to_linear(b)
  return 0.2126 * r_lin + 0.7152 * g_lin + 0.0722 * b_lin
end


-- Function to calculate contrast ratio
local function contrast_ratio(color1, color2)
  local function hex_to_rgb(hex)
    local r = tonumber(hex:sub(2, 3), 16)
    local g = tonumber(hex:sub(4, 5), 16)
    local b = tonumber(hex:sub(6, 7), 16)
    return r, g, b
  end

  local r1, g1, b1 = hex_to_rgb(color1)
  local r2, g2, b2 = hex_to_rgb(color2)

  local lum1 = get_luminance(r1, g1, b1)
  local lum2 = get_luminance(r2, g2, b2)

  local brightest = math.max(lum1, lum2)
  local darkest = math.min(lum1, lum2)

  return (brightest + 0.05) / (darkest + 0.05)
end

describe('Heap Theme - Color Contrast', function()
  setup(function()
    vim.cmd('colorscheme heap')
  end)

  -- Function to test contrast ratio
  local function test_contrast(fg_color, bg_color, min_ratio, description)
    local ratio = contrast_ratio(fg_color, bg_color)
    print(string.format("Contrast ratio for %s: %.2f", description, ratio))
    assert.is_true(ratio >= min_ratio,
      string.format("%s has insufficient contrast: %.2f (needs >= %.2f)",
        description, ratio, min_ratio))
  end

  it('should have sufficient contrast for normal text', function()
    test_contrast(heap.colors.fg, heap.colors.bg, 4.5, "Normal text")
  end)

  it('should have sufficient contrast for comments', function()
    test_contrast(heap.colors.comment, heap.colors.bg, 3.0, "Comments")
  end)

  it('should have sufficient contrast for line numbers', function()
    test_contrast(heap.colors.line_number_fg, heap.colors.bg, 3.0, "Line numbers")
  end)

  it('should have sufficient contrast for keywords', function()
    test_contrast(heap.colors.keyword, heap.colors.bg, 4.5, "Keywords")
  end)

  it('should have sufficient contrast for strings', function()
    test_contrast(heap.colors.string, heap.colors.bg, 4.5, "Strings")
  end)

  it('should have sufficient contrast for numbers', function()
    test_contrast(heap.colors.number, heap.colors.bg, 4.5, "Numbers")
  end)
end)
