# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog.

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
