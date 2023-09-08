require("core.options")
require("core.plugins").setup()

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      require("core.autocmds")
      require("core.keys")
    end
})
