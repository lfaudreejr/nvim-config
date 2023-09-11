return {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{
		"nvim-tree/nvim-web-devicons",
		dependencies = { "DaikyXendo/nvim-material-icon" },
		config = function()
			require("config.web-devicons").setup()
		end,
	},
	{ "yamatsum/nvim-nonicons", config = true, enabled = false },
	{
		"NTBBloodbath/doom-one.nvim",
		lazy = false,
		init = function()
			vim.o.background = "light"
			-- Add color to cursor
			vim.g.doom_one_cursor_coloring = true
			-- Set :terminal colors
			vim.g.doom_one_terminal_colors = true
			-- Enable italic comments
			vim.g.doom_one_italic_comments = false
			-- Enable TS support
			vim.g.doom_one_enable_treesitter = true
			-- Color whole diagnostic text or only underline
			vim.g.doom_one_diagnostics_text_color = false
			-- Enable transparent background
			vim.g.doom_one_transparent_background = false

			-- Pumblend transparency
			vim.g.doom_one_pumblend_enable = false
			vim.g.doom_one_pumblend_transparency = 20

			-- Plugins integration
			vim.g.doom_one_plugin_neorg = true
			vim.g.doom_one_plugin_barbar = false
			vim.g.doom_one_plugin_telescope = false
			vim.g.doom_one_plugin_neogit = true
			vim.g.doom_one_plugin_nvim_tree = true
			vim.g.doom_one_plugin_dashboard = true
			vim.g.doom_one_plugin_startify = true
			vim.g.doom_one_plugin_whichkey = true
			vim.g.doom_one_plugin_indent_blankline = true
			vim.g.doom_one_plugin_vim_illuminate = true
			vim.g.doom_one_plugin_lspsaga = false
		end,
		config = function()
			vim.cmd([[
        colorscheme doom-one
      ]])
		end,
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
		opts = {
			norg = {
				headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
				codeblock_highlight = { "NeorgCodeBlock" },
			},
		},
	},
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("config.onedark").setup()
	-- 	end,
	-- },
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			require("config.alpha").setup()
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("config.notice").setup()
		end,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("config.better-escape").setup()
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
	},
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "digitaltoad/vim-pug", event = "BufReadPost" },
	{
		"TimUntersberger/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			-- "nvim-telescope/telescope.nvim", -- optional
			-- "sindrets/diffview.nvim",        -- optional
			-- "ibhagwan/fzf-lua",              -- optional
		},
		config = function()
			require("config.neogit").setup()
		end,
	},
	{
		"f-person/git-blame.nvim",
		event = "BufEnter",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("config.whichkey").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.telescope").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", pin = true },
			{ "nvim-treesitter/nvim-treesitter-context" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
		event = "BufReadPost",
		cmd = {
			"TSBufDisable",
			"TSBufEnable",
			"TSBufToggle",
			"TSDisable",
			"TSEnable",
			"TSToggle",
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSModuleInfo",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
		},
		build = ":TSUpdate",
		config = function()
			require("config.treesitter").setup()
		end,
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("config.cmp").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
			-- { "SmiteshP/nvim-navic" },
		},
		config = function()
			require("config.lsp").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", opt = true },
		},
		config = function()
			require("config.lualine").setup()
		end,
	},
	{
		"mhartington/formatter.nvim",
		event = "BufEnter",
		config = function()
			require("config.formatter").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("config.explorer").setup({})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufEnter",
		config = function()
			require("config.colorizer").setup()
		end,
	},
	{
		"danymat/neogen",
		event = "BufEnter",
		opts = {
			snippet_engine = "luasnip",
			enabled = true,
			languages = {
				lua = {
					template = {
						annotation_convention = "ldoc",
					},
				},
				python = {
					template = {
						annotation_convention = "google_docstrings",
					},
				},
				rust = {
					template = {
						annotation_convention = "rustdoc",
					},
				},
				javascript = {
					template = {
						annotation_convention = "jsdoc",
					},
				},
				typescript = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
				typescriptreact = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
			},
		},
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			})
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		event = "BufEnter",
		dependencies = {
			"kevinhwang91/promise-async",
			"neovim/nvim-lspconfig",
			"luukvbaal/statuscol.nvim",
		},
		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{
		"cshuaimin/ssr.nvim",
		config = function()
			require("ssr").setup({
				border = "rounded",
				min_width = 50,
				min_height = 5,
				max_width = 120,
				max_height = 25,
				keymaps = {
					close = "q",
					next_match = "n",
					prev_match = "N",
					replace_confirm = "<cr>",
					replace_all = "<leader><cr>",
				},
			})

			vim.keymap.set({ "n", "x" }, "<leader>sr", function()
				require("ssr").open()
			end)
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		version = ">=1.0.0",
		config = function()
			require("config.splits").setup()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("config.copilot").setup()
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		config = function()
			require("config.copilot-cmp").setup()
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("config.chatgpt").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		config = function()
			require("config.blankline").setup()
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"sustech-data/wildfire.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("wildfire").setup()
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
}
