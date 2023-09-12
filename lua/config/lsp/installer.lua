local M = {}

function M.setup(servers, options)
	local lspconfig_exists, lspconfig = pcall(require, "lspconfig")
	if not lspconfig_exists then
		return nil
	end

	local mason_exists, mason = pcall(require, "mason")
	if not mason_exists then
		return
	end

	local mason_lspconfig_exists, mason_lspconfig = pcall(require, "mason-lspconfig")
	if not mason_lspconfig_exists then
		return
	end

	local cmp_nvim_lsp_exists, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not cmp_nvim_lsp_exists then
		return
	end

	local neodev_exists, neodev = pcall(require, "neodev")
	if not neodev_exists then
		return nil
	end

	local lsp_defaults = lspconfig.util.default_config

	local capabilities =
		vim.tbl_deep_extend("force", lsp_defaults.capabilities, cmp_nvim_lsp.default_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

	neodev.setup({})

	local function lsp_settings()
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded" },
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		local command = vim.api.nvim_create_user_command

		command("LspWorkspaceAdd", function()
			vim.lsp.buf.add_workspace_folder()
		end, { desc = "Add folder to workspace" })

		command("LspWorkspaceList", function()
			vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { desc = "List workspace folders" })

		command("LspWorkspaceRemove", function()
			vim.lsp.buf.remove_workspace_folder()
		end, { desc = "Remove folder from workspace" })
	end

	lsp_settings()
	mason.setup({})

	mason_lspconfig.setup({
		-- ensure_installed = vim.tbl_keys(servers),
    ensure_installed = {
      "html",
      "cssls",
      "emmet_ls",
      "jsonls",
      "lua_ls",
      "svelte",
      "eslint",
      "tsserver",
      "tailwindcss"
    }
	})

	mason_lspconfig.setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				settings = servers[server_name],
				filetypes = (servers[server_name] or {}).filetypes,
			})
		end,
	})
end

return M
