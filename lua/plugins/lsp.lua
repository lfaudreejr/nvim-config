return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
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
		},
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
		},
		config = function()
			require("user.lsp").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {},
		lazy = false,
		config = true,
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
