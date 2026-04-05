{ configs, pkgs, ... }:

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
            };
        };
        # nixvim.imports = [ ./modules/nixvim/init.nix ]; # so I don't need to prefix `programs.nixvim`

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
