require("config.options")
--require("colors.customdark").setup()
--require("colors.customlight").setup()
--require("colors.base16").setup()

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.autocmds")
		require("config.keybinds")
	end,
})

local lazy = require("user.lazy")
local lsp = require("user.lsp")

lazy.setup()
lsp.setup()
