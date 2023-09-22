return {
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = { "css", "html", "javascript", "lua", "toml" },
	},
	{
		"navarasu/onedark.nvim",
		enabled = false,
		config = function()
			local onedark = require("onedark")
			onedark.setup({ style = "dark" })
			onedark.load()
		end,
	},
}
