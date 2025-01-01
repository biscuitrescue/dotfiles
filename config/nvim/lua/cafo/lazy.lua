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
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      { "<leader>b",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>nh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>un")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end,
  iii},
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { {'nvim-lua/plenary.nvim'} },
    -- lazy = true,
    -- cmd = require("telescope.builtin"),
  },

  -- {
  --   'goolord/alpha-nvim',
  --   dependencies = { 'kyazdani42/nvim-web-devicons' },
  --   config = function ()
  --     require'alpha'.setup(require'alpha.themes.startify'.config)
  --   end
  -- },
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
  --   'akinsho/bufferline.nvim',
  --   version = "*",
  --   dependencies = 'nvim-tree/nvim-web-devicons',
  --   config = function()
  --     require("bufferline").setup{}
  --   end
  -- },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

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

    {
      "jinzhongjia/LspUI.nvim",
      branch = "main",
      config = function()
        -- require("LspUI").setup({
        --   -- config options go here
        -- })
      end
    },

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
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = {"CmdlineEnter"},
      ft = {"go", 'gomod'},
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },

    -- {'onsails/lspkind.nvim'},
-- nvim v0.8.0
{
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  }
},
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        -- "rcarriga/nvim-notify",
      }
    },

    'LnL7/vim-nix',

    {
      "epwalsh/obsidian.nvim",
      version = "*",  -- recommended, use latest release instead of latest commit
      lazy = true,
      ft = "markdown",
      -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
      -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        --   -- refer to `:h file-pattern` for more examples
        --   "BufReadPre path/to/my-vault/*.md",
        --   "BufNewFile path/to/my-vault/*.md",
        -- },
        dependencies = {
          -- Required.
          "nvim-lua/plenary.nvim",

          -- see below for full list of optional dependencies 👇
        },
        opts = {
          workspaces = {
            {
              name = "personal",
              path = "~/vaults/personal",
            },
            {
              name = "work",
              path = "~/vaults/work",
            },
          },

          -- see below for full list of options 👇
        },
      },

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

    -- {
    --   "MunifTanjim/nougat.nvim",
    -- },
    -- LUALINE
    -- {
    --   "rebelot/heirline.nvim",
    --   -- You can optionally lazy-load heirline on UiEnter
    --   -- to make sure all required plugins and colorschemes are loaded before setup
    --   -- event = "UiEnter",
    -- },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons'}
    },

    -- themes
    {
      "neanias/everforest-nvim",
      version = false,
      lazy = false,
      priority = 1000, -- make sure to load this before all the other start plugins
      -- Optional; default configuration will be used if setup isn't called.
      config = function()
        require("everforest").setup({
          background = "soft",
          transparent_background_level = 0,
          italics = true,
          disable_italic_comments = false,
          on_highlights = function(hl, _)
            hl["@string.special.symbol.ruby"] = { link = "@field" }
          end
        })
      end,
    },
    'shaunsingh/nord.nvim',
    -- {'drewtempelmeyer/palenight.vim', lazy = true},
    'navarasu/onedark.nvim',
    {'NTBBloodbath/doom-one.nvim', lazy = true},
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
    "rebelot/kanagawa.nvim",
    -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
    -- {
    --   "nyoom-engineering/oxocarbon.nvim",
    --   -- lazy = false,
    -- },
    -- {
    --   'andersevenrud/nordic.nvim',
    --   config = function()
    --     -- The table used in this example contains the default settings.
    --     -- Modify or remove these to your liking (this also applies to alternatives below):
    --     require('nordic').colorscheme({
    --       -- Underline style used for spelling
    --       -- Options: 'none', 'underline', 'undercurl'
    --       underline_option = 'undercurl',
    --       -- italic = true,
    --       -- italic_comments = true,
    --       minimal_mode = false,
    --       alternate_backgrounds = false,
    --
    --     })
      -- end
    -- },
    'wilmanbarrios/palenight.nvim',
    {
      'Mofiqul/dracula.nvim',
      -- config = function ()
        -- require('dracula').setup()
        -- vim.cmd.colorscheme 'dracula'
      -- end
    },

    -- 'kdheepak/monochrome.nvim',
    -- 'Abstract-IDE/Abstract-cs',

    -- {
    --   'maxmx03/dracula.nvim',
    --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --   priority = 1000, -- make sure to load this before all the other start plugins
    --   config = function ()
    --     require('dracula').setup()
    --     -- vim.cmd.colorscheme 'dracula'
    --   end
    -- },
  })
