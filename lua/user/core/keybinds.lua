-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP')

-- Move Lines
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", ":m .+1<CR>==")
vim.keymap.set("n", "K", ":m .-2<CR>==")

-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>_", "<cmd>split<cr>", { desc = "Horizontal split" })

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>c", function()
	require("user.utils").close_buffer_with_confirmation()
end, { desc = "Close buffer" })

vim.keymap.set("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force save" })
vim.keymap.set("n", "<C-q>", "<cmd>qa!<cr>", { desc = "Force quit" })

-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

-- buffer navigation
vim.keymap.set("n", "<PageUp>", "<C-u>")
vim.keymap.set("n", "<PageDown>", "<C-d>")

vim.keymap.set("n", "<leader>te", vim.cmd.Ex)
