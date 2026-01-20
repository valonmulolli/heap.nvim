-- Minimal init for tests
vim.opt.rtp:prepend(".")
vim.opt.rtp:prepend("~/.local/share/nvim/site/pack/vendor/start/plenary.nvim")
vim.cmd([[runtime plugin/plenary.vim]])
