{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/NixOS/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  # Standard .config/directory (variables)
  configs = { # NOTE: Add configs HERE !!
    qtile = "qtile";
    nvim = "nvim";
  };
in

{ 
  home = {
    username = "nixnomo";
    homeDirectory = "/home/nixnomo";
    stateVersion = "25.11";
    file = { # only need this for configs NOT inside ~/.config/
      # ".path/nonstandard/foobar".source = ./config/foobar;
    };
    packages = with pkgs; [
      neovim
      ripgrep
      nil
      nixpkgs-fmt
      nodejs
      gcc
    ];
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: { # creates a loop/function
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs; # and use the array `configs` as an argument (NOTE: see above)

  programs = {
    git = {
      enable = true;
      settings = {
        init = {
          defaultBranch = "main";
        };
        user = {
          name = "Nixnomo";
          email = "libere-code@posteo.org";
        };
      };
    };
    bash = {
      enable = true;
      shellAliases = {
        btw = "echo 'Smoke dat red-ice, btw'";
      };
    };
  };

}
