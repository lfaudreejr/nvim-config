return {
	{
		"TimUntersberger/neogit",
		cmd = "Neogit",
		opts = {
			integrations = { diffview = true },
		},
		keys = {
			{ "<leader>gs", "<cmd>Neogit kind=floating<cr>", desc = "Status" },
		},
	},
	{
		"f-person/git-blame.nvim",
		event = "BufEnter",
	},
}
