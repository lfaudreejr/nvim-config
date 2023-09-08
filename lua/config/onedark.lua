local M = {}

function M.setup()
    local status_ok, onedark = pcall(require, "onedark")
    if not status_ok then
        return
    end

    onedark.setup {}

    vim.cmd [[
        colorscheme onedark
    ]]
end

return M