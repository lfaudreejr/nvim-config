local Plugin = { "folke/which-key.nvim" }

Plugin.event = "VeryLazy"

function Plugin.init()
	vim.o.timeout = true
	vim.o.timeoutlen = 300
end

function Plugin.config()
	local wk = require("which-key")

	wk.register({
		["<leader>"] = {
			b = "+buffer",
			c = {
				name = "+code",
			},
			f = {
				name = "+file",
				b = "Find Buffer",
				f = { "<cmd>Telescope find_files<cr>", "Find File" },
				g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
				h = "Find Help",
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				n = { "<cmd>Telescope notify<CR>", "Find Notification" },
			},
			g = "+git",
			n = "+notifications",
			s = "+sessions",
			z = "+environment",
		},
		g = {
			d = "Goto Definition",
			D = "Goto Declaration",
			i = "Goto Implementation",
      l = "Goto Diagnostics",
			o = "Goto Type Definition",
			r = "Goto References",
			s = "Goto Signature Help",
			["<F2>"] = "Rename",
			["<F3>"] = "Format",
			["<F4>"] = "Code Action",
			["gl"] = "Open Float",
			["[d"] = "Goto Prev",
			["]d"] = "Goto Next",
		},
	})

	wk.setup()
end

return Plugin
