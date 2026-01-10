-- Basic tests for the Heap theme
local heap = require('heap')

describe('Heap Theme', function()
  setup(function()
    vim.cmd('colorscheme heap')
  end)

  it('should load without errors', function()
    assert.are.same('heap', vim.g.colors_name)
  end)

  it('should have the main colors defined', function()
    assert.is.truthy(heap.colors)
    assert.is.truthy(heap.colors.bg)
    assert.is.truthy(heap.colors.fg)
    assert.is.truthy(heap.colors.keyword)
    assert.is.truthy(heap.colors.string)
    assert.is.truthy(heap.colors.number)
  end)

  it('should set background to dark', function()
    assert.are.same('dark', vim.o.background)
  end)

  it('should enable termguicolors', function()
    assert.is_true(vim.o.termguicolors)
  end)

  it('should have working highlights', function()
    -- Test a few basic highlight groups
    local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
    local string_hl = vim.api.nvim_get_hl(0, { name = 'String' })

    assert.is.truthy(normal_hl)
    assert.is.truthy(comment_hl)
    assert.is.truthy(string_hl)
  end)

  it('should support configuration options', function()
    -- Test configuration with transparency
    heap.setup({
      transparent = true,
      cursorline = false
    })

    local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local cursorline_hl = vim.api.nvim_get_hl(0, { name = 'CursorLine' })

    -- After applying transparency, Normal background should be nil if transparent
    assert.is_nil(normal_hl.bg, "Normal highlight background should be nil when transparent is true")

    -- CursorLine should have no background when disabled
    assert.is_nil(cursorline_hl.bg, "CursorLine highlight background should be nil when cursorline is false")

    -- Test non-transparent configuration
    heap.setup({
      transparent = false,
      cursorline = true
    })

    local normal_hl2 = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local cursorline_hl2 = vim.api.nvim_get_hl(0, { name = 'CursorLine' })

    -- Background should not be nil when transparency is disabled
    assert.is.truthy(normal_hl2.bg, "Normal highlight background should not be nil when transparent_background is false")
    assert.is.truthy(cursorline_hl2.bg, "CursorLine highlight background should not be nil when cursorline is true")
  end)


end)