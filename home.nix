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

        bash = {
            enable = true;
            shellAliases = {
                rebuild = "sudo nixos-rebuild switch --impure --flake ~/nixos#virtualice";
                v = "nvim";
                echo_home = "echo ${config.home.homeDirectory}";
            };
            initExtra = ''
                if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]; then
                    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                    exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
                fi
            '';
        };

        fish = {
            enable = true;
            plugins = [
            # from nixpkgs (easy way)
                { name = "done"; src = pkgs.fishPlugins.done.src; }
                { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
                { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
                { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
            ];
            binds = { # from HM examples
                "alt-shift-b".command = "fish_commandline_append bat";
                "alt-s".erase = true;
                "alt-s".operate = "preset";
            };
            shellInitLast = ''
                zoxide init fish | source
            '';
            shellAliases = {
                rebuild = "sudo nixos-rebuild switch --impure --flake ~/nixos#virtualice";
                echo_home = "echo ${config.home.homeDirectory}";
                v = "nvim";
                l = "lsd -L";
            };
        };

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
        
        neovim = {
            enable = true;
            defaultEditor = true; # VISUAL=EDITOR=nvim
            extraLuaPackages = luaPkgs: with luaPkgs; [luautf8 ];
            extraPackages = with pkgs; [ # specify deps, ex: LSP
                # lang servers
                lua-language-server # lua
                nil                 # nix lsp
                nixpkgs-fmt         # nix format
            ];
            # extraConfig = ''
	    # ???
            # '';
            initLua = ''
	    vim.cmd(':filetype plugin indent on')

	    local o = vim.opt

	    o.shiftwidth = 4
	    o.softtabstop = 4
	    o.tabstop = 4
	    o.number = true
	    o.relativenumber = true
	    o.smartindent = true
	    o.showmatch = true
	    o.backspace = 'indent,eol,start'

	    o.syntax = "on";

	    vim.cmd.colorscheme 'habamax'

	    local map = vim.keymap.set
	    map('n', '<SPACE>e', ':Ex<CR>')
	    map('n', '<C-s>', ':w<CR>')
	    map('i', '#', 'X#')
            '';
            plugins = with pkgs.vimPlugins; [
                # { plugin = foobar;
                #   config = "print('lua, btw')";
                #   type = "lua";
                # }

                # *.type = "lua"  # TODO: find out how to do this

				# core
                nvim-treesitter
				(nvim-treesitter.withPlugins (p: [ p.c p.nix p.lua p.python p.ini p.toml p.json p.rust p.html p.bash p.fish p.zsh p.markdown p.toml p.todotxt p.tmux p.vim ] ))
                nvim-lspconfig

                telescope-nvim
            ];
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
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
