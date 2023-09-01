local P = { 'echasnovski/mini.files', version = false }

P.lazy = false

function P.config()
  local MiniFiles = require('mini.files')
  MiniFiles.setup()
  local minifiles_toggle = function()
    if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
  end
  vim.keymap.set('n', '<leader>e', minifiles_toggle , { desc = "File Explorer" })
end

return P
