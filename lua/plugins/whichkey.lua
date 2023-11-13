return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		local opts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}

		local setup = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				presets = {
					oerators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			-- add operators that will trigger motion and text object completion
			-- to enable all native operators, set the preset / operators plugin above
			-- operators = { gc = "Comments" },
			key_labels = {
				-- override the label used to display some keys. It doesn't effect WK in any other way.
				-- For example:
				-- ["<space>"] = "SPC",
				-- ["<cr>"] = "RET",
				-- ["<tab>"] = "TAB",
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = "rounded", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
			show_help = true, -- show help message on the command line when the popup is visible
			triggers = "auto", -- automatically setup triggers
			-- triggers = {"<leader>"} -- or specify a list manually
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for key maps that start with a native binding
				-- most people should not need to change this
				i = { "j", "k" },
				v = { "j", "k" },
			},
		}

		local mappings = {
			["e"] = { "<cmd>Neotree reveal<CR>", "Explorer" },
			["p"] = {
				function()
					require("lazy").home()
				end,
				"Manager",
			},
			["w"] = { "<cmd>w<CR>", "Save" },
			["q"] = { "<cmd>confirm q<Cr>", "Quit" },

			b = {
				name = "Buffer",
				c = {
					function()
						require("user.utils").close_buffer_with_confirmation()
					end,
					"Close",
				},
				d = {
					function()
						require("mini.bufremove").delete(0, false)
					end,
					"Delete",
				},
				D = {
					function()
						require("mini.bufremove").delete(0, true)
					end,
					"Delete (Force)",
				},
				r = { name = "Rename" },
			},

			l = {
				name = "Lsp",
				a = "Code Action",
				d = "Diagnostics",
				f = {
					name = "Format",
					f = { "<cmd>Format<CR>", "Format" },
					w = { "<cmd>FormatWrite<CR>", "Format Write" },
				},
				g = {
					name = "Gen",
					c = {
						function()
							require("neogen").generate({ type = "class" })
						end,
						"Class",
					},
					d = {
						function()
							require("neogen").generate({ type = "file" })
						end,
						"Annotate",
					},
					f = {
						function()
							require("neogen").generate({ type = "func" })
						end,
						"Function",
					},
					t = {
						function()
							require("neogen").generate({ type = "type" })
						end,
						"Type",
					},
				},
				r = { name = "references" },
				w = {
					"workspace",
					s = "symbols",
				},
			},

			f = {
				name = "File Search",
				c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
				f = { "<cmd>Telescope find_files<cr>", "Find Files" },
				g = { "<cmd>Telescope git_files<cr>", "Git Files" },
				r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
				w = { "<cmd>Telescope live_grep<cr>", "Find Word" },
			},

			g = {
				name = "Git",
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        h = {
          name = "Hunk",
          d = "Diff This",
          p = "Preview Hunk",
          r = "Reset Hunk",
          R = "Reset Buffer",
          s = "Stage Hunk",
          S = "Stage Buffer",
          u = "Undo Stage"
        },
				l = { "<cmd>lua require('user.utils.terminal').git_client_toggle()<CR>", "LazyGit" },
				o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
				s = { "<cmd>Neogit kind=floating<CR>", "Status" },
			},

			s = {
				name = "Search",
				b = { "<cmd>Telescope buffers<cr>", "Buffers" },
				d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
				h = { "<cmd>Telescope help_tags<cr>", "Help" },
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				r = { "<cmd>Telescope resume<cr>", "Resume" },
				s = { name = "Document Symbols" },
				S = { name = "Workspace Symbols" },
				w = {
					function()
						require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
					end,
					"Search Word",
				},
			},

			S = {
				name = "Sessions",
				r = {
					function()
						require("persistence").load()
					end,
					"Restore Session",
				},
				l = {
					function()
						require("persistence").load({ last = true })
					end,
					"Restore Last Session",
				},
				D = {
					function()
						require("persistence").stop()
					end,
					"Don't Save Current Session",
				},
			},

			t = {
				name = "Toggle",
				c = {
					function()
						if vim.o.background == "dark" then
							require("colors.customlight").setup()
						else
							require("colors.customdark").setup()
						end
					end,
					"Colors",
				},
			},

			z = {
				name = "Fold",
				R = {
					function()
						require("ufo").openAllFolds()
					end,
					"Open All",
				},
				M = {
					function()
						require("ufo").closeAllFolds()
					end,
					"Close All",
				},
			},
		}

		wk.setup(setup)
		wk.register(mappings, opts)
	end,
}
