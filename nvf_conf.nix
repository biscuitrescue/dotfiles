{
  ...
}: {
  programs.nvf = {
    enable = true;
    settings.vim = {
      useSystemClipboard = true;
      options = {
        shiftwidth = 2;
        tabstop = 4;
        scrolloff = 4;
        laststatus = 3;
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
        lsplines.enable = true;
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

      terminal.toggleterm.lazygit = {
        enable = true;
        mappings.open = "<leader>lg";
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

      filetree.nvimTree = {
        enable = true;
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
          key = "<leader>s";
          desc = "Global Replace";
          mode = "n";
          silent = true;
          action = "[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]";
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
      ];

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
      syntaxHighlighting.enable = true;
      tabline.nvimBufferline.enable = true;

      ui = {
        colorizer.enable = true;
        noice.enable = true;
      };

      utility.preview.glow.enable = true;
      visuals = {
        rainbow-delimiters.enable = true;
        nvim-web-devicons.enable = true;
        fidget-nvim = {
          enable = true;
          setupOpts.integration.nvim-tree.enable = true;
        };
      };
      withPython3 = true;
    };
  };
}
