local P = { 'echasnovski/mini.files', version = false }

function P.config()
  require('mini.files').setup()

  vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', { desc = "File Explorer" })
end

return P
