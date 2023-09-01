local P = { "echasnovski/mini.jump" }

P.event = "VeryLazy"
P.opts = {}
P.keys = { "f", "F", "t", "T" }

function P.config(_, opts)
  require("mini.jump").setup(opts)
end

return P
