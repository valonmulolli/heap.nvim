-- Heap Dark - Entry point
local heap = require('heap')

-- Always ensure the correct variant is used when calling via :colorscheme
heap.setup({ variant = "dark" })

-- Return the module to make it available if needed
return heap
