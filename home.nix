{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/NixOS/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  # Standard .config/directory (variables)
  configs = { # NOTE: Add configs HERE !!
    qtile = "qtile";
    nvim = "nvim";
    hypr = "hypr";
    foot = "foot";
    # bash = "bash";
    zsh = "zsh";
  }; in

{ 
  # imports = [ # didn't work
  #   ./modules/neovim.nix
  # ];

  home = {
    username = "nixnomo";
    homeDirectory = "/home/nixnomo";
    stateVersion = "25.11";
    file = { # only need this for configs NOT inside ~/.config/
      # ".path/nonstandard/foobar".source = ./config/foobar; # directories
    };
    packages = with pkgs; [
      # better gnu-core
      ripgrep
      fd
      bat
      sd
      fzf
      # editor
      neovim
      # lsp
      nil
      nixpkgs-fmt
      # compilers
      nodejs
      gcc
      # QOL
      tealdeer
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
      # enable with UWSM
      # profileExtra = ''
      #   if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #     exec uwsm start -S hyprland-uwsm.desktop
      #   fi
      # '';
    };
  };

}
