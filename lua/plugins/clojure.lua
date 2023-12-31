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
	-- {
	-- 	"Olical/conjure",
	-- 	ft = { "clojure", "fennel", "python" }, -- etc
	-- 	-- [Optional] cmp-conjure for cmp
	-- 	dependencies = {
	-- 		{
	-- 			"PaterJason/cmp-conjure",
	-- 		},
	-- 	},
	-- 	config = function()
	--      vim.g["conjure#mapping#doc_word"] = ""
	-- 		require("conjure.main").main()
	-- 		require("conjure.mapping")["on-filetype"]()
	-- 	end,
	-- 	init = function()
	-- 		-- Set configuration options here
	-- 		vim.g["conjure#debug"] = true
	-- 	end,
	-- },
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
		end,
	},
}
