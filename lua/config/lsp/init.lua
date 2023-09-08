local M = {}

local servers = {
	gopls = {},
	html = {
		filetypes = { "html", "twig", "hbs", "handlebars", "svelte" },
	},
	clojure_lsp = {},
	cssls = {},
	emmet_ls = {},
	eslint = {},
	jsonls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	pyright = {},
	rust_analyzer = {},
	svelte = {},
	tsserver = {},
	vimls = {},
}

local function on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	require("config.lsp.keymaps").setup(client, bufnr)
end

local opts = {
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
}

function M.setup()
	require("config.lsp.installer").setup(servers, opts)
end

return M
