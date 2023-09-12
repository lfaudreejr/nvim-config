local Colors = {}

function Colors.setup()
  local google_light = require("user.plugins.config.colors.google-light")

  google_light.setup()
end

return Colors
