local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if  not vim.loop.fs_stat(lazypath) then
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
    tag = '0.1.5',
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
        {
            'mrcjkb/rustaceanvim',
            version = '^4', -- Recommended
            ft = { 'rust' },
        },
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

          --   { "epwalsh/obsidian.nvim",
          --   version = "*",  -- recommended, use latest release instead of latest commit
          --   lazy = false,
          --   ft = "markdown",
          --   dependencies = {
          --     "nvim-lua/plenary.nvim",
          --   },
          --   opts = {
          --     workspaces = {
          --       {
          --         name = "notes",
          --         path = "~/vaults/notes",
          --       },
          --     },
          --
          --     -- see below for full list of options 👇
          --   },
          --   completion = {
          --     nvim_cmp = true,
          --     min_chars = 2,
          --     new_notes_dir = "current_dir",
          --     prepend_note_id = true,
          --     prepend_note_path = false,
          --   },
          --   mappings = {
          --     ["gf"] = {
          --       action = function()
          --         return require("obsidian").util.gf_passthrough()
          --       end,
          --       opts = { noremap = false, expr = true, buffer = true },
          --     },
          --     -- Toggle check-boxes.
          --     ["<leader>ch"] = {
          --       action = function()
          --         return require("obsidian").util.toggle_checkbox()
          --       end,
          --       opts = { buffer = true },
          --     },
          --   },
          --   templates = {
          --     subdir = "templates",
          --     date_format = "%Y-%m-%d",
          --     time_format = "%H:%M",
          --     -- A map for custom variables, the key should be the variable and the value a function
          --     substitutions = {},
          --   },
          --   picker = {
          --     name = "telescope.nvim",
          --     mappings = {
          --       -- Create a new note from your query.
          --       new = "<C-x>",
          --       -- Insert a link to the selected note.
          --       insert_link = "<C-l>",
          --     },
          --   },
          --   note_id_func = function(title)
          --     -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          --     -- In this case a note with the title 'My new note' will be given an ID that looks
          --     -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          --     local suffix = ""
          --     if title ~= nil then
          --       -- If title is given, transform it into valid file name.
          --       suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          --     else
          --       -- If title is nil, just add 4 random uppercase letters to the suffix.
          --       for _ = 1, 4 do
          --         suffix = suffix .. string.char(math.random(65, 90))
          --       end
          --     end
          --     return tostring(os.time()) .. "-" .. suffix
          --   end,
          -- },

            --   {
            --     "nvim-neorg/neorg",
            --     build = ":Neorg sync-parsers",
            --     lazy = false, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
            --     -- tag = "*",
            --     dependencies = { "nvim-lua/plenary.nvim" },
            --     config = function()
            --       require("neorg").setup {
            --         load = {
            --           ["core.defaults"] = {}, -- Loads default behaviour
            --           ["core.concealer"] = {}, -- Adds pretty icons to your documents
            --           ["core.dirman"] = { -- Manages Neorg workspaces
            --           config = {
            --             workspaces = {
            --               notes = "~/Documents/Notes/",
            --             },
            --           },
            --         },
            --       },
            --     }
            --   end,
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

            "folke/trouble.nvim",
            dependencies = { "kyazdani42/nvim-web-devicons" },
            opts = {
            },
            {
              "folke/zen-mode.nvim",
              opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
              },
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

            -- themes
            'shaunsingh/nord.nvim',
            {
              'maxmx03/dracula.nvim',
              lazy = false, -- make sure we load this during startup if it is your main colorscheme
              priority = 1000, -- make sure to load this before all the other start plugins
              config = function ()
                -- require('dracula').setup()
                -- vim.cmd.colorscheme 'dracula'
              end
            },
            {'drewtempelmeyer/palenight.vim', lazy = true},
            {'NTBBloodbath/doom-one.nvim', lazy = true},
            { "catppuccin/nvim", name = "catppuccin", lazy = true },
            "rebelot/kanagawa.nvim",
            'tanvirtin/monokai.nvim',
            { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
            { "savq/melange-nvim" },
            {
              "nyoom-engineering/oxocarbon.nvim",
              lazy = false,
            },
            {
              "neanias/everforest-nvim",
              version = false,
              lazy = false,
              priority = 1000, -- make sure to load this before all the other start plugins
              -- Optional; default configuration will be used if setup isn't called.
              config = function()
                require("everforest").setup({
                  -- Your config here
                })
              end,
            },
            {
              'andersevenrud/nordic.nvim',
              config = function()
                -- The table used in this example contains the default settings.
                -- Modify or remove these to your liking (this also applies to alternatives below):
                require('nordic').colorscheme({
                  -- Underline style used for spelling
                  -- Options: 'none', 'underline', 'undercurl'
                  underline_option = 'undercurl',
                  italic = true,
                  italic_comments = true,
                  minimal_mode = false,
                  alternate_backgrounds = false,

                })
              end
            }
          })
