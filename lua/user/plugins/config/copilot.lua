local M = {}

function M.setup()
	local status_ok, copilot = pcall(require, "copilot")
	if not status_ok then
		return nil
	end

	local opts = {
		panel = {
			enabled = false, -- default true
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
			layout = {
				position = "bottom", -- | top | left | right
				ratio = 0.4,
			},
		},
		suggestion = {
			enabled = false, -- default true
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = "<M-l>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			lua = true,
			javascript = true,
			typescript = true,
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		},
		copilot_node_command = "node", -- Node.js version must be > 16.x
		-- copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v18.17.1/bin/node", -- Node.js version must be > 16.x
		server_opts_overrides = {},
	}

	copilot.setup(opts)
end

return M
