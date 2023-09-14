local M = {}

function M.setup()
	local status_ok, formatter = pcall(require, "formatter.util")
	if not status_ok then
		return nil
	end

	-- Utilities for creating configurations
	local util = require("formatter.util")

	formatter.setup({
		-- Enable or disable logging
		logging = true,
		-- Set the log level
		log_level = vim.log.levels.WARN,
		filetype = {
			go = {
				require("formatter.filetypes.go").gofmt,
			},
			javascript = {
				-- require("formatter.filetypes.javascript").prettierd,
				require("formatter.filetypes.javascript").prettier,
			},
			typescript = {
				require("formatter.filetypes.typescript").prettier,
			},
			-- other formatters ...
			svelte = {
				-- require("formatter.filetypes.svelte").prettier,
				-- require("formatter.filetypes.javascript").prettierd,
				require("formatter.filetypes.javascript").prettier,
			},
			html = {
				require("formatter.filetypes.html").prettier,
			},
			css = {
				require("formatter.filetypes.css").prettier,
			},
			json = {
				require("formatter.filetypes.json").fixjson,
			},
			lua = {
				-- "formatter.filetypes.lua" defines default configurations for the
				-- "lua" filetype
				require("formatter.filetypes.lua").stylua,

				-- You can also define your own configuration
				function()
					-- Supports conditional formatting
					if util.get_current_buffer_file_name() == "special.lua" then
						return nil
					end

					-- Full specification of configurations is down below and in Vim help
					-- files
					return {
						exe = "stylua",
						args = {
							"--search-parent-directories",
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
							"--",
							"-",
						},
						stdin = true,
					}
				end,
			},
		},
	})
end

return M
