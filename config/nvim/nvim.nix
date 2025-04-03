{
  inputs,
  pkgs,
  lib,
  ...
}: {
  vim.package = inputs.neovim-overlay.packages.${pkgs.system}.neovim;
  vim = {
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };
  };
  statusLine.lualine.enable = true;
  telescope.enable = true;
  autocomplete.nvim-cmp.enable = true;

  languages = {
    enableLSP = true;
    enableTreesitter = true;
    nix.enable = true;
    rust.enable = true;
    clang.enable = true;
    python.enable = true;
    markdown.enable = true;
    lua.enable = true;
  };
}
