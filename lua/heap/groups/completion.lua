-- Highlight group: completion
local M = {}

M.apply_completion_highlights = function(colors, opts)
	-- Nvim-cmp completion menu highlights
	local completion_highlights = {
		CmpItemAbbr = { fg = colors.fg },
		CmpItemAbbrDeprecated = { fg = colors.fg_dark, strikethrough = true },
		CmpItemAbbrMatch = { fg = colors.term_yellow, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = colors.term_yellow, bold = true },
		CmpItemMenu = { fg = colors.comment },
		CmpItemKind = { fg = colors.keyword },
		CmpItemKindText = { fg = colors.string },
		CmpItemKindMethod = { fg = colors.function_name },
		CmpItemKindFunction = { fg = colors.function_name },
		CmpItemKindConstructor = { fg = colors.class_name },
		CmpItemKindField = { fg = colors.property },
		CmpItemKindVariable = { fg = colors.variable },
		CmpItemKindClass = { fg = colors.class_name },
		CmpItemKindInterface = { fg = colors.class_name },
		CmpItemKindModule = { fg = colors.class_name },
		CmpItemKindProperty = { fg = colors.property },
		CmpItemKindUnit = { fg = colors.number },
		CmpItemKindValue = { fg = colors.constant_builtin },
		CmpItemKindEnum = { fg = colors.storage_type },
		CmpItemKindKeyword = { fg = colors.keyword },
		CmpItemKindSnippet = { fg = colors.tag },
		CmpItemKindColor = { fg = colors.term_cyan },
		CmpItemKindFile = { fg = colors.term_blue },
		CmpItemKindReference = { fg = colors.term_magenta },
		CmpItemKindFolder = { fg = colors.term_blue },
		CmpItemKindEnumMember = { fg = colors.constant_builtin },
		CmpItemKindConstant = { fg = colors.constant_builtin },
		CmpItemKindStruct = { fg = colors.storage_type },
		CmpItemKindEvent = { fg = colors.keyword },
		CmpItemKindOperator = { fg = colors.operators },
		CmpItemKindTypeParameter = { fg = colors.storage_type },
	}

	for hl_name, hl_def in pairs(completion_highlights) do
		vim.api.nvim_set_hl(0, hl_name, hl_def)
	end
end

-- Apply telescope highlights

function M.apply(colors, opts)
	M.apply_completion_highlights(colors, opts)
end

return M
