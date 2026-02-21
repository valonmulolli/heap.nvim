-- Highlight group: custom user overrides
local M = {}

M.apply_custom_highlights = function(opts)
	if opts.tweak_highlight then
		for hl_name, hl_def in pairs(opts.tweak_highlight) do
			vim.api.nvim_set_hl(0, hl_name, hl_def)
		end
	end
end

-- Apply terminal colors

function M.apply(_, opts)
	M.apply_custom_highlights(opts)
end

return M
