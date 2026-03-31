{ config, pkgs, lib, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos/dot.files";
    configs = { # Standard .config/directory
      hyprland = "hyprland";
      mango = "mango";
      shells = "shells";
      # nvim = "nvim/extra";
    };
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
  imports = [ # wtf, det funka?
    # ./modules/hyprland/init.nix # NOTE: disabled
    ./modules/mango.nix
  ];

  # Iterate over xdg configs and map them accordingly
  xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;
  # xdg.configFile."mango" = {
  #     source = create_symlink "${dotfiles}/mango/extra.conf";
  #     recursive = true;
  #   };
  # xdg.configFile."nvim" = {
  #     source = create_symlink "${dotfiles}/nvim/extra";
  #     recursive = true;
  #   };

  home = {
    username = "kashnomo";
    homeDirectory = lib.mkDefault "/home/kashnomo";
    stateVersion = "25.11";
    packages = with pkgs; [
      # better core-utils
      lsd # ls
      zoxide # cd
      trash-cli # rm
      bat # cat
      ripgrep # grep
      fd # find
      sd # sed

      # other usefull utils
      tealdeer
      fzf
      yazi
      pass
      gnupg
    ];
  };

  programs = {
    home-manager.enable = true; # lets home-manager install/manage itself

    fzf = {
      # settings
      # ...
    };

    git = {
      enable = true;
      # settings
      # ...
    };

    # shell
    bash = {
      enable = true;
      shellAliases = {
        btw = "echo I sniff that Red-ICE(NixOS), btw";
        rebuild = "sudo nixos-rebuild switch --impure --flake ~/nixos#redice";
      };
    };
    zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      initContent = let
          zshFirst = lib.mkOrder 500 ''# zshFirst
'';
          zshDefault = lib.mkOrder 1000 ''# zshDefault
source ~/.config/shells/zsh/extra.zshrc.zsh
'';
          zshLast = lib.mkOrder 1500 ''# zshLast
'';
        in
        lib.mkMerge [ zshFirst zshDefault zshLast ];
    };
    fish = {
      enable = true;
      interactiveShellInit = ''# interactiveShellInit
      '';
      shellInit = ''# shellInit
      source ~/.config/shells/fish/extra.config.fish
      '';
    };

    # editor
    neovim = {
      enable = true;
    };

    # web/mail browsers
    # thunderbird.enable = true;
    # firefox.enable = true;
    librewolf = {
      enable = true;
      profiles = {
        redIcedWolf = {
	  id = 0;
	  bookmarks = {};
	  containers = {};
	  extensions = {};
	  search = {};
	  settings = {};
	};
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
