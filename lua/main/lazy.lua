local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- 
-- Configure lazy.nvim
require("lazy").setup({
  defaults = { lazy = false, version = nil },
  install = { missing = true },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin"
      }
    }
  },
  spec = {
	  { import = "plugins" },
    { import = "plugins.lsp" },
    { import = "plugins.ux" },
    { import = "plugins.ux.mini" }
  },
})

vim.keymap.set("n", "<leader>zz", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })
