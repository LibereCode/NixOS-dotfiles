{ config, pkgs, ... }:
{
    programs = {
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
	};
}
