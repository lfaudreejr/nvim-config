local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>")
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

keymap("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
keymap("n", "<leader>_", "<cmd>split<cr>", { desc = "Horizontal split" })

keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })
keymap("n", "<leader>c", function() require("utils").close_buffer_with_confirmation() end, { desc = "Close buffer" })

keymap("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force save" })
keymap("n", "<C-q>", "<cmd>qa!<cr>", { desc = "Force quit" })

-- keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
-- keymap("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
-- keymap("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
-- keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
keymap("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

-- buffer navigation
keymap("n", "<PageUp>", "<C-u>")
keymap("n", "<PageDown>", "<C-d>")
