{ config, pkgs, ... }:

let
  zsh_plugs = "${config.xdg.dataHome}/zsh/plugins";
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
    shells = "shells";
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

    fzf = { # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.fzf.enable
      enable = true;
      enableZshIntegration = true;

    };
    zsh = { # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable
    # https://search.nixos.org/options?channel=25.11&query=zsh
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      # .zshenv
      envExtra = '' # commands added to `.zshenv`
      ''; # TODO: envvar.sh instead in configuration.nix
      sessionVariables = {
        ZCACHE = "$HOME/.cache/zsh";
        ZPLUGS = "$ZCACHE/plugins";   # used in auto-plug.zsh
      };
      # promptInit = ''
      # ''; # TODO p10k

      initContent = ''
        source $ZDOTDIR/zshrc_extra.zsh
      '';

      enableCompletion = true;

      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        path = "${config.xdg.dataHome}/zsh/zhistory";
        save = 91101;
        saveNoDups = true;
        size = 91101;
      };
      historySubstringSearch.enable = true;

      # plugins
      plugins = [
        # { # using a local path (manually cloned) makes it 'impure' (bad?)
        #   name = "zsh-syntax-highlighting";
        #   # file = "zsh-syntax-highlighting.zsh";
        #   src = "${zsh_plugs}/zsh-syntax-highlighting"; # can be a git-url
        # }
      ];
      prezto = {
        enable = true;
        prompt.theme = "powerlevel10k";
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "autosuggestions" # add ?
          "syntax-highlighting" # add ?
          "prompt"
        ];
      };

      # autosuggestion = {
      #   enable = true;
      # };
      # syntaxHighlighting = {
      #   enable = true;
      # };

      # TODO: ? zoxide ? foot ? nix-index ?
    };

  };

}
