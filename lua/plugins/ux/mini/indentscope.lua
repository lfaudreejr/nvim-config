local P = { 'echasnovski/mini.indentscope', version = false }

P.event = "VeryLazy"

function P.config()
  require('mini.indentscope').setup({})
end

return P
