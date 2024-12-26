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
			--copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v18.17.1/bin/node"
		},
	}
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	-- event = "InsertEnter",
	-- 	dependencies = { "zbirenbaum/copilot.lua" },
	-- 	opts = {},
	-- },
}
