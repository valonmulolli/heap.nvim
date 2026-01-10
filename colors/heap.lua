-- Main entry point for the Heap theme
local heap = require('heap')

-- Always ensure the correct variant is used when calling via :colorscheme
heap.setup({ variant = "default" })

-- Return the module to make it available if needed
return heap
