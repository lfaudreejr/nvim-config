local M = {}

function M.setup()
    local status_ok, web_devicons = pcall(require, "nvim-web-devicons")
    if not status_ok then
        return
    end

    web_devicons.setup {
        override = require("nvim-material-icon").get_icons(),
    }
end

return M