# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog.

## 1.0.0 (2026-05-30)


### Features

* add Go-specific syntax highlights for Neovim 0.12+ built-in go.vim ([c82c3ec](https://github.com/valonmulolli/heap.nvim/commit/c82c3ecacfc7f87c8b3b0d79fdbc0d5da5008617))
* add modern plugin support (fzf-lua, oil, harpoon, render-markdown), LSP inlay hints, and GitHub Actions CI ([3abf97a](https://github.com/valonmulolli/heap.nvim/commit/3abf97a8751ab5ee2b9126490a5e7b4e39eebe9c))
* improved visual selection, terminal colors, and nvim-notify support ([6f0f8ee](https://github.com/valonmulolli/heap.nvim/commit/6f0f8ee1848853df4a870d00f1f5ac4823afbe69))


### Bug Fixes

* correct Go highlight group names, patch edge cases ([520309a](https://github.com/valonmulolli/heap.nvim/commit/520309ae7e9362348a8f30447144df86e85b3b8e))
* corrected repository name and user handle in lazy.nvim installation instructions ([b021239](https://github.com/valonmulolli/heap.nvim/commit/b0212397863c9f84a459a9cb82aad2e895e78754))
* **lualine:** add y-section extensions for all modes; align heap-dark insert ([5a87837](https://github.com/valonmulolli/heap.nvim/commit/5a8783783008dbf220b030487854f494a96cfd4f))
* respect transparent_background option on dark variant ([7c2a262](https://github.com/valonmulolli/heap.nvim/commit/7c2a26221433537c891b7ed8239d37c906aa6b4d))
* restore consistency in installation example ([d049481](https://github.com/valonmulolli/heap.nvim/commit/d049481578f44dd320fd7ec945a9ba7728d85d59))
* **theme:** harden setup and correct highlights/lualine behavior ([31496e8](https://github.com/valonmulolli/heap.nvim/commit/31496e87479f70f826edb0bb41d4e7517b3ba891))

## [Unreleased]

### Added
- Internal structure under `lua/heap/` (`groups/`, `palette/`, `types/`).
- Plenary-based test suite and GitHub Actions test workflow.
- Extras for `fzf`, `ghostty`, `kitty`, `lazygit`, and `yazi`.
- Optional `zignite.nvim` highlight integration.
- `lua/heap/utils.lua` with cache helpers and plugin auto-detection.
- `:HeapFetch` command to clear cache and reload the colorscheme.

### Changed
- `setup()` now resets options from defaults on each call.
- Colorscheme loading path updated to the new module layout.
