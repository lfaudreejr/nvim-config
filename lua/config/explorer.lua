local M = {}

function M.setup()
	local status_ok, neotree = pcall(require, "nvim-tree")
	if not status_ok then
		return nil
	end

	neotree.setup({
		view = {
			width = 30,
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},
	})
end

return M
