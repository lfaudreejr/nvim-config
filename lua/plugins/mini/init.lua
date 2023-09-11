return {
	{
		"echasnovski/mini.bufremove",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
	{
		"echasnovski/mini.indentscope",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("mini.indentscope").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		event = "VeryLazy",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function()
			require("config.mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.jump",
		event = "VeryLazy",
		keys = { "f", "F", "t", "T" },
		config = function()
			require("mini.jump").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "msa", -- Add surrounding in Normal and Visual modes
					delete = "msd", -- Delete surrounding
					find = "msf", -- Find surrounding (to the right)
					find_left = "msF", -- Find surrounding (to the left)
					highlight = "msh", -- Highlight surrounding
					replace = "msr", -- Replace surrounding
					update_n_lines = "msn", -- Update `n_lines`

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},
			})
		end,
	},
}
