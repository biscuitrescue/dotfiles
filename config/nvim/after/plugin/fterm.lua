require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.8,
        width = 0.8,
    },
    lazy = true,
})

-- Example keybindings
vim.keymap.set('n', '<leader>ot', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader>ot', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
