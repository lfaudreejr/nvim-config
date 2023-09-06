local P = { "mhartington/formatter.nvim" }

function P.config()
	-- Utilities for creating configurations
	local util = require("formatter.util")

	require("formatter").setup({
		-- Enable or disable logging
		logging = true,
		-- Set the log level
		log_level = vim.log.levels.WARN,
		filetype = {
      go = {
        require("formatter.filetypes.go").gofmt,
      },
			javascript = {
				require("formatter.filetypes.javascript").prettierd,
			},
			typescript = {
				require("formatter.filetypes.javascript").prettier,
			},
			-- other formatters ...
			svelte = {
				-- require("formatter.filetypes.svelte").prettier,
        require("formatter.filetypes.javascript").prettierd,
			},
			html = {
				require("formatter.filetypes.html").prettier,
			},
			css = {
				require("formatter.filetypes.css").prettier,
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

	vim.keymap.set("n", "<leader>cf", "<cmd>Format<cr>")
	vim.keymap.set("n", "<leader>cw", "<cmd>FormatWrite<cr>")
end

return P
