local P = {}

function P.setup()
	local lsp_ok, lsp = pcall(require, "lsp-zero")
	if not lsp_ok then
		return nil
	end

	local navic_ok, navic = pcall(require, "nvim-navic")

	lsp.preset({})

	lsp.on_attach(function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp.default_keymaps({ buffer = bufnr, preserve_mappings = false, omit = { "K" } })

		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>")
		vim.keymap.set("n", "<leader>lws", function()
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
		vim.keymap.set("n", "<leader>lca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>lrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>lrn", function()
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

	-- lsp.skip_server_setup({ "tsserver" })

	require("mason").setup({})
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"rust_analyzer",
			"gopls",
			"clojure_lsp",
			"jsonls",
			"tailwindcss",
			"svelte",
		},
		automatic_installation = { exclude = { "tsserver" } },
		handlers = {
			lsp.default_setup,
			lua_ls = function()
				-- (Optional) configure lua language server
				local lua_opts = lsp.nvim_lua_ls()
				require("lspconfig").lua_ls.setup(lua_opts)
			end,
		},
	})

	-- lsp.setup()

	require("typescript-tools").setup({})

	require("user.lsp.cmp").setup()
end

return P
