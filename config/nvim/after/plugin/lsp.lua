local lsp = require('lsp-zero').preset({
	name = 'recommended',
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

lsp.setup_servers({
    'python-language-server',
    'bash-language-server',
    'clangd',
    'clang-format',
    'cpptools',
    'lua-server-language'
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
