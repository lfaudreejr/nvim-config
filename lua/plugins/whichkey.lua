return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		local n_opts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		wk.setup({
			window = {
				border = "single",
				position = "bottom",
			},
		})

		local n_keys = {
			["w"] = { "<cmd>w<CR>", "Save" },
			["q"] = { "<cmd>confirm q<Cr>", "Quit" },

			b = {
				name = "+buffer",
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
			},

			l = {
				name = "+lsp",
				c = {
					name = "code",
					a = "action",
				},
				d = "open diagnostics",
				f = {
					name = "format",
					f = { "<cmd>Format<CR>", "Format" },
					w = { "<cmd>FormatWrite<CR>", "Format Write" },
				},
				g = {
					name = "+gen",
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
				r = {
					name = "references",
					r = "list",
					n = "rename",
				},
				w = {
					"workspace",
					s = "symbols",
				},
			},

			g = {
				name = "+git",
				s = { "<cmd>Neogit kind=floating<CR>", "Status" },
			},

			p = {
				name = "+project",
				c = {
					name = "+color",
					t = {
						function()
							if vim.o.background == "dark" then
								require("colors.customlight").setup()
							else
								require("colors.customdark").setup()
							end
						end,
						"Toggle",
					},
				},
				e = { "<cmd>Neotree reveal<CR>", "Explorer" },
				m = {
					function()
						require("lazy").home()
					end,
					"Manager",
				},
			},

			s = {
				name = "+search",
				b = {
					function()
						require("telescope.builtin").buffers()
					end,
					"Buffers",
				},
				d = {
					function()
						require("telescope.builtin").diagnostics()
					end,
					"Diagnostics",
				},
				l = {
					function()
						require("telescope.builtin").live_grep()
					end,
					"Live Grep",
				},
				g = {
					function()
						require("telescope.builtin").git_files()
					end,
					"Git Files",
				},
				h = {
					function()
						require("telescope.builtin").help_tags()
					end,
					"Help",
				},
				r = {
					function()
						require("telescope.builtin").resume()
					end,
					"Resume",
				},
				w = {
					function()
						require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
					end,
					"Current Word",
				},
				f = {
					function()
						require("telescope.builtin").find_files()
					end,
					"Files",
				},
			},

			S = {
				name = "+session",
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

			z = {
				name = "+fold",
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

		wk.register(n_keys, n_opts)
	end,
}
