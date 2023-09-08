local M = {}

function M.setup()
	local status_ok, splits = pcall(require, "smart-splits")
	if not status_ok then
		return nil
	end

	splits.setup({})
	-- moving between splits
	vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
	vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
	vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
	vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
end

return M
