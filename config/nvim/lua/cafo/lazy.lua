local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { {'nvim-lua/plenary.nvim'} },
        lazy = true,
        cmd = require("telescope.builtin"),
    },

    {
        'goolord/alpha-nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    'numToStr/FTerm.nvim',
    'theprimeagen/harpoon',

    -- 'vimwiki/vimwiki',
    -- {'chipsenkbeil/vimwiki-server.nvim', tag = 'v0.1.0-alpha.5' },
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        lazy = true,
    },
    {
        'mbbill/undotree',
        lazy = true,
        cmd = 'UndotreeToggle'
    },
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },
    {'norcalli/nvim-colorizer.lua'},
    {
        'notjedi/nvim-rooter.lua',
        config = function()
            require'nvim-rooter'.setup()
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        dependencies = {'kyazdani42/nvim-web-devicons'},

    },
    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },

    "lukas-reineke/indent-blankline.nvim",
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    },

    -- LUALINE
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons'}
    },
    {
        'maxmx03/dracula.nvim',
        lazy = true,
    },
    {
        'Soares/base16.nvim',
        lazy = true
    },
-- Packer
    'drewtempelmeyer/palenight.vim',
    {'NTBBloodbath/doom-one.nvim', lazy = true},
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
})
