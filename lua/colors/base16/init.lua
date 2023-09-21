local Colors = {}

function Colors.setup()
  local enabled = false

  if not enabled then
    return nil
  end

  local color = require("colors.base16.schemes")

  color.setup()
end

return Colors
