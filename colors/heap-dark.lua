-- Heap Dark - Entry point
local heap = require('heap')

-- Always ensure the correct variant is used when calling via :colorscheme
heap.load({ variant = "dark" })

-- Return the module to make it available if needed
return heap
