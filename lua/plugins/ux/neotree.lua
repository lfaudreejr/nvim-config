local P = {
    "nvim-neo-tree/neo-tree.nvim",
}

P.enabled = false

P.branch = "v3.x"
P.event = "VeryLazy"

P.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  "MunifTanjim/nui.nvim",
}

function P.config()
  local config = require("plugins.ux.neotree.config")
  require("neo-tree").setup({config})
  vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<cr>")
end

return P
