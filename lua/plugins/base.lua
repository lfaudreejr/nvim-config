return {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{
		"nvim-tree/nvim-web-devicons",
		dependencies = { "DaikyXendo/nvim-material-icon" },
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-icon").get_icons(),
			})
		end,
	},
	{ "yamatsum/nvim-nonicons", config = true, enabled = false },
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({})
			vim.cmd([[colorscheme onedark]])
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup({
				mapping = { "jk" },
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
	    	-- stylua: ignore
	    	keys = {
	    	  { "<leader>sr", function() require("persistence").load() end, desc = "Restore Session" },
	    	  { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
	    	  { "<leader>sD", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
	    	},
	},
	{
		"kosayoda/nvim-lightbulb",
    event = "VeryLazy",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	},
	{ "christoomey/vim-tmux-navigator" },
	{ "digitaltoad/vim-pug", event = "BufReadPost" },
}
