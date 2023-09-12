local M = {}

function M.setup()
	local status_ok, whichkey = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local n_opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	}

	whichkey.setup({
		window = {
			border = "single",
			position = "bottom",
		},
	})

  local n_keys = require("user.plugins.config.keymaps.n")

	whichkey.register(n_keys, n_opts)
end

return M
