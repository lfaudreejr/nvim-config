local M = {}

function M.setup()
	local status_ok, copilot_cmp = pcall(require, "copilot_cmp")
	if not status_ok then
		return nil
	end

	copilot_cmp.setup()
end

return M
