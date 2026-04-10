{ pkgs, config, ... }:

let
    nixhome = "${config.home.homeDirectory}/nixos"; # TODO: change to your fav path
    dotfiles = "${nixhome}/lnsconfig";
    create_lns = path: config.lib.file.mkOutOfStoreSymlink path;
    lns = { # I think you can create a sub/dir if changing the "key" into "sub/dir"
        # nvim = "nvim";
    };
in

{
    imports = [
        ./modules/hypr/init.nix
        ./modules/nvim/init.nix
        ./modules/shells/init.nix
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

            nodejs
            gcc
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

        # configFile = {
        #     "nvim" = {
        #         source = create_lns "${dotfiles}/nvim";
        #         recursive = true;
        #     };
        # };
        configFile = builtins.mapAttrs 
        (name: subpath: {
            source = create_lns "${dotfiles}/${subpath}";
            recursive = true;
            }) lns;
    };

    services = {
        ssh-agent = {
            enable = true;
        };
    };

	# editorconfig = {
	# TODO:
	# };

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
        # TODO: ssh-agent, bash-agent ?

        kitty = {
            enable = true;
            enableGitIntegration = true;
            # environment = {
            #     Can set EnvVar ?
            # };
            font = {
                package = pkgs.nerd-fonts.victor-mono;
                name = "VictorMono Nerd Font";
                size = 14;
            };
            keybindings = {
                "ctrl+c" = "copy_or_interrupt";
            };
            settings = {
                scrollback_lines = 9723;
                enable_audio_bell = false;
                update_check_interval = 0;
                confirm_os_window_close = 0;
            };
            themeFile = "HachikoRed";
            # extraConfig = ''
            # '';
        };
        
        # More CLI tools
        # enable<Shell>Integration = home.shell.enableShellIntegration = true; (so unnecessary)
        zoxide = {
            enable = true;
        };
        yazi = {
            enable = true;
            # TODO: theme, controls
        };
        lsd = {
            enable = true;
            # TODO: Icons, colors, config
        };
        fzf = {
            enable = true;
            changeDirWidgetCommand = "fd --type d";
            changeDirWidgetOptions = [
                "--preview 'tree -C {} | head -200'"
            ];
            colors = {
                bg = "#1e1e1e";
                "bg+" = "#1e1e1e";
                fg = "#d4d4d4";
                "fg+" = "#d4d4d4";
            };
            fileWidgetCommand = "fd --type f";
            fileWidgetOptions = [
                "--preview 'bat {}'"
            ];
            # historyWidgetOptions = [ "--sort" "--exact" ];
        };
        fd = {
            enable = true;
            hidden = true;
            ignores = [
                ".git/"
            ];
            extraOptions = [
                "--absolute-path"
            ];
        };
        bat = {
            enable = true;
            config = {
                pager = "less -iRFMx4 --dumb";
                theme = "TwoDark";
                color = "auto";
                style = "full,-numbers,-grid";
                italic-text = "always";
            };
            extraPackages = with pkgs.bat-extras; [
            batdiff batman batgrep batwatch ];
        };


        # GUI
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
