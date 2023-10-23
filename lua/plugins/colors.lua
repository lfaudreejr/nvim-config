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
	{
		"rose-pine/neovim",
		name = "rose-pine",
    enabled = false,
		config = function()
      vim.o.background = "light"
      require("rose-pine").setup {}
      vim.cmd('colorscheme rose-pine')
		end,
	},
}
