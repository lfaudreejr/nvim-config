require "main.options"
require "main.lazy"

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("main.autocmds")
    require("main.keymaps")
  end
})
