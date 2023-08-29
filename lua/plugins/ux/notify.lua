local P = { "rcarriga/nvim-notify" }

P.keys = {
  {
    "<leader>nd",
    function()
      require("notify").dismiss({ silent = true, pending = true })
    end,
    desc = "Dismiss all Notifications",
  },
}

P.opts = {
  timeout = 2500,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
}

function P.init()
  -- when noice is not enabled, install notify on VeryLazy
  local Util = require("utils")
  if not Util.has("noice.nvim") then
    Util.on_very_lazy(function()
      vim.notify = require("notify")
    end)
  end
end

return P
