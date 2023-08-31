return {
	{ "tpope/vim-dispatch", dependencies = { "clojure-vim/vim-jack-in", "radenling/vim-dispatch-neovim" } },
	-- Parinfer parens management for Clojure
	{
		"gpanders/nvim-parinfer",
		ft = { "clojure" },
		-- init = function()
		-- 	vim.g.parinfer_force_balance = true
		-- 	vim.g.parinfer_comment_chars = ";;"
		-- end,
	},
	{
		"Olical/conjure",
		ft = { "clojure", "fennel", "python" }, -- etc
		-- [Optional] cmp-conjure for cmp
		dependencies = {
			{
				"PaterJason/cmp-conjure",
				config = function()
					local cmp = require("cmp")
					local config = cmp.get_config()
					table.insert(config.sources, {
						name = "buffer",
						option = {
							sources = {
								{ name = "conjure" },
							},
						},
					})
					cmp.setup(config)
				end,
			},
		},
		config = function(_, opts)
			require("conjure.main").main()
			require("conjure.mapping")["on-filetype"]()
		end,
		init = function()
			-- Set configuration options here
			vim.g["conjure#debug"] = true

			vim.api.nvim_create_autocmd("BufNewFile", {
				group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
				pattern = { "conjure-log-*" },
				callback = function()
					vim.diagnostic.disable(0)
				end,
				desc = "Conjure Log disable LSP diagnostics",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("comment_config", { clear = true }),
				pattern = { "clojure" },
				callback = function()
					vim.bo.commentstring = ";; %s"
				end,
				desc = "Lisp style line comment",
			})
		end,
	},
}
