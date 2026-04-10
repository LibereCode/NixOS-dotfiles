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
	};
}
