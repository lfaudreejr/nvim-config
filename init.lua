require("config.options")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.autocmds")
		require("config.keybinds")
	end,
})

local lazy = require("user.lazy")
local lsp = require("user.lsp")

if vim.g.colors_name == nil then
	require("colors.customdark").setup()
else
	vim.notify(vim.g.colors_name, 3)
end

lazy.setup()
lsp.setup()
