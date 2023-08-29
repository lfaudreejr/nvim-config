local P = { "echasnovski/mini.pairs" }

P.event = "VeryLazy"

function P.config(_, opts)
  require("mini.pairs").setup(opts)
end

return P
