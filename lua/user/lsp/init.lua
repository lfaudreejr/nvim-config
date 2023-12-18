local P = {}

function P.setup()
	local lsp_ok, lsp_zero = pcall(require, "lsp-zero")
	if not lsp_ok then
		return nil
	end

	local navic_ok, navic = pcall(require, "nvim-navic")

	lsp_zero.preset({})

	lsp_zero.on_attach(function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false, omit = { "K" } })

		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "<leader>ss", function()
			vim.lsp.buf.document_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>sS", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>ld", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>la", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>lr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>br", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)

		if navic_ok and client.server_capabilities["documentSymbolProvider"] then
			navic.attach(client, bufnr)
		end
	end)

	-- (Optional) Configure lua language server for neovim
	-- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

	lsp_zero.ensure_installed({
		"lua_ls",
		"rust_analyzer",
		"gopls",
		"clojure_lsp",
		"jsonls",
		"tailwindcss",
		"svelte",
		"ocamllsp",
	})

	lsp_zero.skip_server_setup({ "tsserver" })
	lsp_zero.skip_server_setup({ "rust_analyzer" })
	-- require("mason").setup({})
	-- require("mason-lspconfig").setup({
	-- 	ensure_installed = {
	-- 		"lua_ls",
	-- 		"rust_analyzer",
	-- 		"gopls",
	-- 		"clojure_lsp",
	-- 		"jsonls",
	-- 		"tailwindcss",
	-- 		"svelte",
	-- 		"ocamllsp",
	-- 	},
	-- 	automatic_installation = { exclude = { "tsserver" } },
	-- 	handlers = {
	-- 		lsp_zero.default_setup,
	-- 		lua_ls = function()
	-- 			-- (Optional) configure lua language server
	-- 			local lua_opts = lsp_zero.nvim_lua_ls()
	-- 			require("lspconfig").lua_ls.setup(lua_opts)
	-- 		end,
	-- 		tsserver = function()
	-- 			require("typescript-tools").setup({})
	-- 		end,
	-- 		rust_analyzer = function()
	-- 			local rust_tools = require("rust-tools")
	-- 			rust_tools.setup({
	-- 				on_attach = function(_, bufnr)
	-- 					vim.keymap.set("n", "<leader>la", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
	-- 				end,
	-- 			})
	-- 		end,
	-- 	},
	-- })

	local lspconf = require("lspconfig")
	lspconf.lua_ls.setup(lsp_zero.nvim_lua_ls())
	lspconf.gopls.setup({})
	lspconf.hls.setup({})
	lspconf.clojure_lsp.setup({})
	lspconf.jsonls.setup({})
	lspconf.tailwindcss.setup({})
	lspconf.svelte.setup({})
	lspconf.ocamllsp.setup({})

	lsp_zero.setup()

	require("typescript-tools").setup({})

	local rust_tools = require("rust-tools")
	rust_tools.setup({
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "<leader>la", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
		end,
	})

	-- require("typescript-tools").setup({})

	require("user.lsp.cmp").setup()
end

return P
