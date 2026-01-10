-- Test runner for Heap theme
-- This script runs all tests for the Heap theme

local M = {}

-- Run all tests
M.run_all_tests = function()
  print("Running Heap theme tests...")
  
  -- Run basic tests
  print("Running basic tests...")
  require('tests.basic_test')
  
  -- Run color contrast tests
  print("Running color contrast tests...")
  require('tests.color_contrast_test')
  
  print("All tests completed!")
end

-- Run a specific test
M.run_test = function(test_name)
  print("Running test: " .. test_name)
  require('tests.' .. test_name)
  print("Test completed: " .. test_name)
end

return M