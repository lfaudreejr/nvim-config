local M = {}

function M.setup()
	local status_ok, nvimtree = pcall(require, "nvim-tree")
	if not status_ok then
		return nil
	end
	-- disable netrw at the very start of your init.lua
	--vim.g.loaded_netrw = 1
	--vim.g.loaded_netrwPlugin = 1

	nvimtree.setup({
		view = {
			width = 30,
		},
		renderer = {
			group_empty = true,
			indent_width = 1,
			indent_markers = {
				enable = false,
			},
			icons = {
				show = {
					folder_arrow = false,
				},
			},
			highlight_opened_files = "name",
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
