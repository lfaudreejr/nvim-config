return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			-- { "hrsh7th/nvim-cmp" }, -- Required
			{ "yioneko/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required

			-- language things
			{ "simrat39/rust-tools.nvim" },
			-- {
			-- 	"ray-x/lsp_signature.nvim",
			-- 	event = "VeryLazy",
			-- 	opts = {},
			-- 	config = function(_, opts)
			-- 		local lsp_signature = require("lsp_signature")
			-- 		
   --        lsp_signature.setup(opts)
			--
			-- 		vim.keymap.set({ "n" }, "<C-k>", function()
			-- 			lsp_signature.toggle_float_win()
			-- 		end, { silent = true, noremap = true, desc = "toggle signature" })
			--
			-- 		vim.keymap.set({ "n" }, "<Leader>k", function()
			-- 			vim.lsp.buf.signature_help()
			-- 		end, { silent = true, noremap = true, desc = "toggle signature" })
			-- 	end,
			-- },
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			icons = {
				File = " ",
				Module = " ",
				Namespace = " ",
				Package = " ",
				Class = " ",
				Method = " ",
				Property = " ",
				Field = " ",
				Constructor = " ",
				Enum = " ",
				Interface = " ",
				Function = " ",
				Variable = " ",
				Constant = " ",
				String = " ",
				Number = " ",
				Boolean = " ",
				Array = " ",
				Object = " ",
				Key = " ",
				Null = " ",
				EnumMember = " ",
				Struct = " ",
				Event = " ",
				Operator = " ",
				TypeParameter = " ",
			},
		},
	},
	{
		"onsails/lspkind.nvim",
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
}
