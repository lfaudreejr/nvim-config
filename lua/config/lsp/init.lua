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
			completion = {
				callSnippet = "Replace",
			},
		},
	},
	pyright = {},
	rust_analyzer = {},
	svelte = {},
	tsserver = {},
	vimls = {},
	tailwindcss = {
		filetypes_exclude = { "markdown" },
	},
}

local function on_attach(client, bufnr)
	print("attaching ", client)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	-- vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"

	-- Configure key mappings
	require("config.lsp.keymaps").setup(client, bufnr)
end

local opts = {
	flags = {
		debounce_text_changes = 150,
	},
}

function M.setup()
	require("config.lsp.installer").setup(servers, opts)

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			on_attach(client, bufnr)
		end,
	})
end

return M
