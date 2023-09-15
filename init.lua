local lazy = require("user.core.lazy")
local plugins = require("user.plugins")
local lsp = require("user.core.lsp")

require("user.plugins.config.colors").setup()
require("user.core.options")

require("customdark").setup()
--require("customlight").setup()

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("user.core.autocmds")
		require("user.core.keybinds")
	end,
})

lazy.setup(plugins)
lsp.setup()
