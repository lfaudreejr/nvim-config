return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		-- event = "InsertEnter",
		event = "BufEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = {
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["*"] = true,
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		-- event = "InsertEnter",
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = {},
	},
}
