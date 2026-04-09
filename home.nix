{ pkgs, config, ... }:

{
    imports = [
        ./modules/hypr/init.nix
    ];

    home = {
        username = "nixnomo";
        homeDirectory = "/home/nixnomo";
        stateVersion = "25.11";
        packages = with pkgs; [
            waybar
            kitty
            (pkgs.writeShellApplication {
                name = "ns-tv";
                runtimeInputs = with pkgs; [
                    fzf
                    nix-search-tv
                ];
                text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
            })
        ];
    };

    xdg = {
        enable = true;

        configHome = "${config.home.homeDirectory}/config"; # This bricked my config?
        # cacheHome = "~/cache";    # Can chage this and below,
        # dataHome = "~/data";      # but default is good 
        # stateHome = "~/state";

        userDirs = {
            enable = true;
            createDirectories = true;
            documents = "${config.home.homeDirectory}/Docs";
            # Has defaults directories (already enabled
            templates = "${config.xdg.userDirs.documents}/Templates";
            extraConfig = { # allows adding non-standard dirs
                media = "${config.home.homeDirectory}/Docs";
            };
            pictures = "${config.xdg.userDirs.extraConfig.media}/Pics";
            videos = "${config.xdg.userDirs.extraConfig.media}/Vids";
            music = "${config.xdg.userDirs.extraConfig.media}/Music";
        };
    };

    services = {
        ssh-agent = {
            enable = true;
        };
    };
    programs = {

        # Terminal
        git = { # TODO: config
            enable = true;
            settings = {
                user = {
                    name = "LibereCode";
                    email = "libere-code@posteo.org";
                };
            };
        };
        ssh = {
            enable = true;
        };
        bash = {
            enable = true;
            shellAliases = {
                rebuild = "sudo nixos-rebuild switch --impure --flake ~/nixos#virtualice";
                v = "nvim";
                echo_home = "echo ${config.home.homeDirectory}";
            };
        };

        # Gui
        librewolf = {
            enable = true;
            profiles = {
                LibreIce = { # profile name
                    isDefault = true;
                    name = "LibreIce";
                    path = "LibreIce";
                    # TODO:
                    # bookmarks = {};
                    # containers = {};
                    # extensions = {};
                    # search = {}; 
                    # settings = {};
                };
            };
            # settings = { # TODO:
            #     ... # librewolf (general) setting
            # };
        };
    };
}
