local P = { 'echasnovski/mini.surround', version = false }

P.event = "VeryLazy"
function P.config()
  require('mini.surround').setup({})
end

return P
