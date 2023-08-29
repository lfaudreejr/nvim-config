local P = { "zbirenbaum/copilot-cmp" }

function P.config()
  require("copilot_cmp").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
end

return P

