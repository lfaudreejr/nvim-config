local M = {}

function M.setup()
	local status_ok, whichkey = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local n_opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	}

	local n_keys = {
		["w"] = { "<cmd>update!<CR>", "Save" },
		["q"] = { "<cmd>q!<Cr>", "Quit" },

		b = {
			name = "+buffer",
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

		c = {
			name = "+code",
			f = { "<cmd>Format<CR>", "Format" },
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
						require("neogen").generate()
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
			w = { "<cmd>FormatWrite<CR>", "Format Write" },
		},

		g = {
			name = "+git",
			s = { "<cmd>Neogit kind=floating<CR>", "Status" },
		},

		p = {
			name = "+plugins",
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
			f = {
				function()
					require("telescope.builtin").find_files()
				end,
				"Files",
			},
			g = {
				function()
					require("telescope.builtin").live_grep()
				end,
				"via Grep",
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
					require("telescope.builtin").grep_string()
				end,
				"Current Word",
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

		t = {
			name = "+toggle",
			e = { "<cmd>NvimTreeToggle<CR>", "Tree" },
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

	whichkey.setup({
		window = {
			border = "single",
			position = "bottom",
		},
	})

	whichkey.register(n_keys, n_opts)
end

return M
