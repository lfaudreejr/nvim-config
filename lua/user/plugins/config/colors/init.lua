local Colors = {}

function Colors.setup()
  local enabled = false

  if not enabled then
    return nil
  end

  local color = require("user.plugins.config.colors.schemes")

  color.setup()
end

return Colors
