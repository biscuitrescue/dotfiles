vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>fs", ":w<CR>")
vim.keymap.set("n", "<leader>fr", ":so<CR>")
vim.keymap.set("n", "<leader><leader>", ":")
vim.keymap.set("n", "<leader>cd", ":cd ")
vim.keymap.set("n", "<leader>wv", ":vs<CR>")
vim.keymap.set("n", "<leader>w", "<C-w>")
-- vim.keymap.set("n", "<leader>or", ":RnvimrToggle<CR>")

vim.keymap.set("n", "<leader>op", ":e ")