{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # tools for telescope.nvim
    ripgrep
    fd
    fzf

    # lsp
    lua-language-server
    nil # nix lsp
    nixpkgs-fmt
    
    # lazy.nvim
    nodejs
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # there was another?

    # NOTE: (optional), can use nix instead of lazy.nvim to manage plugs
    # use `plugins` key
    # plugins = with pkgs.vimPlugins; [
    #   telescope-nvim
    #   nvim-treesitter
    #   nvim-lspconfig
    #   # any other plugins
    # ];
  };
}
