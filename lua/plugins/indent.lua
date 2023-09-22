return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		config = function()
			local blankline = require("indent_blankline")

			blankline.setup({
				buftype_exclude = {
					"nofile",
					"terminal",
				},
				filetype_exclude = {
					"help",
					"startify",
					"aerial",
					"alpha",
					"dashboard",
					"lazy",
					"neogitstatus",
					"NvimTree",
					"neo-tree",
					"Trouble",
				},
				context_patterns = {
					"class",
					"return",
					"function",
					"method",
					"^if",
					"^while",
					"jsx_element",
					"^for",
					"^object",
					"^table",
					"block",
					"arguments",
					"if_statement",
					"else_clause",
					"jsx_element",
					"jsx_self_closing_element",
					"try_statement",
					"catch_clause",
					"import_statement",
					"operation_type",
				},
				show_trailing_blankline_indent = false,
				use_treesitter = true,
				char = "▏",
				context_char = "▏",
				show_current_context = true,
			})
		end,
	},
}
