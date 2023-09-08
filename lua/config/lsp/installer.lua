local M = {}

function M.setup(servers, options)
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

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason.setup {}
    mason_lspconfig.setup {}

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = options.on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end
    }
end

return M
