-- Highlight group: syntax
local M = {}

M.apply_syntax_highlights = function(colors, opts)
	-- Syntax highlights grouped for better organization and performance
	local syntax_highlights = {
		Comment = { fg = colors.comment },
		Constant = { fg = colors.constant_builtin },
		String = { fg = colors.string },
		Character = { fg = colors.string },
		Number = { fg = colors.number },
		Boolean = { fg = colors.number },
		Float = { fg = colors.number },
		Identifier = { fg = colors.variable },
		Function = { fg = colors.function_name },
		Statement = { fg = colors.keyword },
		Conditional = { fg = colors.keyword },
		Repeat = { fg = colors.keyword },
		Label = { fg = colors.keyword },
		Operator = { fg = colors.operators },
		Keyword = { fg = colors.keyword },
		Exception = { fg = colors.keyword },
		PreProc = { fg = colors.keyword },
		Include = { fg = colors.keyword },
		Define = { fg = colors.keyword },
		Macro = { fg = colors.keyword },
		PreCondit = { fg = colors.keyword },
		Type = { fg = colors.storage_type },
		StorageClass = { fg = colors.storage },
		Structure = { fg = colors.storage },
		Typedef = { fg = colors.storage },
		Special = { fg = colors.tag },
		SpecialChar = { fg = colors.string_escape },
		Tag = { fg = colors.tag },
		Delimiter = { fg = colors.punctuation },
		SpecialComment = { fg = colors.comment },
		Debug = { fg = colors.term_red },
		Underlined = { underline = true },
		Ignore = { fg = colors.fg },
		Error = { fg = colors.invalid },
		Todo = { fg = colors.term_yellow },
		ZigBuiltinFn = { fg = colors.zig_builtin_fn },
		ZigString = { fg = colors.zig_string },
		ZigStringDelimiter = { fg = colors.zig_string },
	}

	for hl_name, hl_def in pairs(syntax_highlights) do
		vim.api.nvim_set_hl(0, hl_name, hl_def)
	end
end

-- Apply treesitter highlights

function M.apply(colors, opts)
	M.apply_syntax_highlights(colors, opts)
end

return M
