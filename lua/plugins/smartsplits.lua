local P = { "mrjones2014/smart-splits.nvim", version = ">=1.0.0" }

function P.config()
	require("smart-splits").setup({})
	-- moving between splits
	vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
	vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
	vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
	vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
end

return P
