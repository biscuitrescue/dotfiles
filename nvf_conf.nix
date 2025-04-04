{
  ...
}: {
  programs.nvf = {
    enable = true;
    settings.vim = {
      useSystemClipboard = true;
      options = {
        shiftwidth = 2;
        tabstop = 2;
      };
      viAlias = false;
      vimAlias = true;
      lsp = {
        enable = true;
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      statusline.lualine.enable = true;
      telescope.enable = true;

      autocomplete = {
        enableSharedCmpSources = true;
        blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          sourcePlugins.emoji.enable = true;
          sourcePlugins.ripgrep.enable = true;
        };
      };

      autopairs.nvim-autopairs.enable = true;
      binds.whichKey.enable = true;
      comments.comment-nvim.enable = true;
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

      languages = {
        enableLSP = true;
        enableTreesitter = true;
        clang.enable = true;
        nix.enable = true;
        rust.enable = true;
      };

    };
  };
}
