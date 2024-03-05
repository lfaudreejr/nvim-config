-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local config = require("custom.plugins.configs.filetree")
		require("neo-tree").setup(config)

		vim.keymap.set("n", "<leader>fo", "<cmd>Neotree reveal<cr>", { desc = "Open" })
	end,
}
