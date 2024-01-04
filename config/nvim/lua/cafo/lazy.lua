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
        tag = '0.1.:',
        dependencies = { {'nvim-lua/plenary.nvim'} },
        -- lazy = true,
        -- cmd = require("telescope.builtin"),
    },

    {
        'goolord/alpha-nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
    {
        'christoomey/vim-tmux-navigator',
        lazy=false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
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

    -- {
    --     'akinsho/bufferline.nvim',
    --     version = "*",
    --     dependencies = 'nvim-tree/nvim-web-devicons',
    --     config = function()
    --         require("bufferline").setup{}
    --     end
    -- },

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
        config = function()
            vim.o.winwidth = 20
            vim.o.winminwidth = 15
            require('windows').setup()
        end
    },
    -- 'Raimondi/delimitMate',
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
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "kyazdani42/nvim-web-devicons", -- optional dependency
        },
        -- opts = {
        --     -- configurations go here
        -- },
    },
    -- LSP
    

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lua'},
    {'rafamadriz/friendly-snippets'},
    {'L3MON4D3/LuaSnip'},
    {'williamboman/mason-lspconfig.nvim'},
    {'williamboman/mason.nvim'},
    -- {
    --     'VonHeikemen/lsp-zero.nvim',
    --     branch = 'v1.x',
    --     dependencies = {
    --         -- LSP Support
    --         {'neovim/nvim-lspconfig'},             -- Required
    --         {'williamboman/mason.nvim'},           -- Optional
    --         {'williamboman/mason-lspconfig.nvim'}, -- Optional
    --
    --         -- Autocompletion
    --         {'hrsh7th/nvim-cmp'},         -- Required
    --         {'hrsh7th/cmp-nvim-lsp'},     -- Required
    --         {'hrsh7th/cmp-buffer'},       -- Optional
    --         {'hrsh7th/cmp-path'},         -- Optional
    --         {'saadparwaiz1/cmp_luasnip'}, -- Optional
    --         {'hrsh7th/cmp-nvim-lua'},     -- Optional
    --
    --         -- Snippets
    --         {'L3MON4D3/LuaSnip'},             -- Required
    --         {'rafamadriz/friendly-snippets'}, -- Optional
    --     }
    -- },


    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },

    'LnL7/vim-nix',

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
    -- {'akinsho/bufferline.nvim', version = "*", dependencies = 'kyazdani42/nvim-web-devicons'},

    -- themes
    'shaunsingh/nord.nvim',
    -- 'dracula/vim',
    'Mofiqul/dracula.nvim',
    -- { 'maxmx03/dracula.nvim', lazy = true, },
    -- 'JoosepAlviste/palenightfall.nvim',
    {'drewtempelmeyer/palenight.vim', lazy = true},
    {'NTBBloodbath/doom-one.nvim', lazy = true},
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
})
