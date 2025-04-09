{
  ...
}: {
  programs.nvf = {
    enable = true;
    settings.vim = {
      useSystemClipboard = true;
      options = {
        shiftwidth = 2;
        ignorecase = true;
        smartcase = true;
        signcolumn = "yes";
        confirm = true;
        autoindent = true;
        expandtab = true;
        linebreak = true;
        tabstop = 4;
        scrolloff = 4;
        laststatus = 3;
        mouse = "a";
        mousescroll = "ver:20";

        swapfile = false;
        backup = false;
        undofile = true;

        hlsearch = false;
        incsearch = true;
        updatetime = 50;
        cursorline = true;
        cursorcolumn = false;
        conceallevel = 2;
      };

      viAlias = false;
      vimAlias = true;
      lsp = {
        enable = true;
        lightbulb = {
          enable = true;
          autocmd.enable = true;
        };
        lspconfig.enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        null-ls.enable = true;
        trouble.enable = true;
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };

      statusline.lualine.enable = true;
      telescope.enable = true;

      terminal.toggleterm = {
        enable = true;
        lazygit = {
          enable = true;
          mappings.open = "<leader>lg";
        };
      };

      autocomplete = {
        enableSharedCmpSources = true;
        blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          sourcePlugins.emoji.enable = true;
          sourcePlugins.ripgrep.enable = true;
        };
      };

      # autopairs.nvim-autopairs.enable = true;
      binds.whichKey.enable = true;
      # comments.comment-nvim.enable = true;
      dashboard.alpha.enable = true;

      diagnostics.nvim-lint = {
        enable = true;
      };

      filetree.neo-tree= {
        enable = true;
        setupOpts.filesystem.hijack_netrw_behavior = "disabled";
        # mappings.toggle = "<C-n>";
        # openOnSetup = false;
      };

      git = {
        enable = true;
        # git-conflict.enable = true;
      };

      globals = {
        mapleader = " ";
      };

      keymaps = [
        {
          key = "<C-n>";
          mode = ["n" "x" "i" "v"];
          desc = "Toggle Neo-Tree";
          silent = true;
          action = ":Neotree toggle<CR>";
        }
        {
          key = "<leader>s";
          desc = "Global Replace";
          mode = "n";
          silent = true;
          action = ":%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>";
        }
        {
          key = "<leader>wq";
          desc = "Quit Window";
          mode = "n";
          silent = true;
          action = ":q<CR>";
        }
        {
          key = "<leader>fs";
          desc = "Write File";
          mode = "n";
          silent = false;
          action = ":w<CR>";
        }
        {
          key = "<leader>wv";
          desc = "Vertical Split";
          mode = "n";
          silent = false;
          action = ":vs<CR>";
        }
        {
          key = "<leader>w";
          desc = "Window";
          silent = true;
          mode = "n";
          action = "<C-w>";
        }
        {
          key = "<A-e>";
          mode = ["n" "x" "v"];
          silent = true;
          action = "$";
        }
        {
          key = "<A-w>";
          mode = ["n" "x" "v"];
          silent = true;
          action = "^";
        }
        {
          key = "<A-1>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 1<CR>";
        }
        {
          key = "<A-2>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 2<CR>";
        }
        {
          key = "<A-3>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 3<CR>";
        }
        {
          key = "<A-4>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 4<CR>";
        }
        {
          key = "<A-5>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 5<CR>";
        }
        {
          key = "<A-6>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 6<CR>";
        }
        {
          key = "<A-7>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 7<CR>";
        }
        {
          key = "<A-8>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 8<CR>";
        }
        {
          key = "<A-9>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferGoto 9<CR>";
        }
        {
          key = "<A-0>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferLast<CR>";
        }
        {
          key = "<A-c>";
          mode = ["n" "x"];
          silent = false;
          action = "<Cmd>BufferClose<CR>";
        }
        {
          key = "K";
          mode = "v";
          desc = "Move Line up";
          silent = true;
          action = ":m '<-2<CR>gv=gv";
        }
        {
          key = "J";
          mode = "v";
          desc = "Move Line Down";
          silent = true;
          action = ":m '>+1<CR>gv=gv";
        }
      ];

      treesitter = {
        indent.enable = true;
        enable = true;
        fold = true;
      };

      languages = {
        enableLSP = true;
        enableTreesitter = true;
        clang.enable = true;
        nix.enable = true;
        rust.enable = true;
        python.enable = true;
      };

      mini = {
        align.enable = true;
        comment.enable = true;
        pairs.enable = true;
        basics.enable = true;
        surround.enable = true;
        indentscope.enable = true;
        icons.enable = true;
        animate.enable = true;
        notify.enable = true;
      };

      snippets.luasnip.enable = true;
      spellcheck.enable = true;
      tabline.nvimBufferline.enable = true;

      ui = {
        colorizer.enable = true;
        noice.enable = true;
      };

      utility.preview.glow.enable = true;
      visuals = {
        indent-blankline.enable = true;
        indent-blankline.setupOpts.scope.enabled = true;
        rainbow-delimiters.enable = true;
        nvim-web-devicons.enable = true;
        fidget-nvim = {
          enable = true;
          setupOpts.integration.nvim-tree.enable = true;
        };
        cinnamon-nvim = {
          enable = true;
          # setupOpts.keymaps.basic = true;
          # setupOpts.keymaps.extra = true;
        };
      };
      
      withPython3 = true;

    };
  };
}
