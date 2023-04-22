require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})

vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<C-a>", vim.cmd.NvimTreeFocus)
