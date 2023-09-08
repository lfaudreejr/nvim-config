local M = {}

function M.setup()
	local status_ok, copilot_cmp = pcall(require, "copilot-cmp")
	if not status_ok then
		return nil
	end

	copilot_cmp.setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
end

return M
