return {
	{
		"tpope/vim-dispatch",
		dependencies = { "clojure-vim/vim-jack-in", "radenling/vim-dispatch-neovim" },
		ft = { "clojure" },
	},
	{
		"gpanders/nvim-parinfer",
		ft = { "clojure" },
		init = function()
		  vim.g.parinfer_force_balance = true
			vim.g.parinfer_comment_chars = ";;"
		end,
	},
	{
		"Olical/conjure",
		ft = { "clojure", "fennel", "python" }, -- etc
		-- [Optional] cmp-conjure for cmp
		dependencies = {
			{
				"PaterJason/cmp-conjure",
			},
		},
		config = function()
			require("conjure.main").main()
			require("conjure.mapping")["on-filetype"]()
		end,
		init = function()
			-- Set configuration options here
			vim.g["conjure#debug"] = true
		end,
	},
}
