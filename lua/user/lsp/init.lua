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

    vim.keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>')

		if navic_ok and client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end
	end)

	-- (Optional) Configure lua language server for neovim
	require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

	lsp.skip_server_setup({ "tsserver" })

	require("typescript-tools").setup({})

	lsp.setup()

	require("user.lsp.cmp").setup()
end

return P
