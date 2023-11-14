return {
	"folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
	config = function()
		local wk = require("which-key")

		wk.setup({})

		wk.register({
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
					u = "Undo Stage",
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
		}, { prefix = "<leader>" })
	end,
}
