{ config, pkgs, ... }:

{
    programs = {
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
				# ssh-agent stuff. Converted from bash example on !aw
				if [ -z $(pgrep -u "$USER" 'ssh-agent' 2>/dev/null) ]
					ssh-agent -c -t 3h > "$XDG_RUNTIME_DIR/ssh-agent.env"
				end
				if [ ! -f "$SSH_AUTH_SOCK" ]
					source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
				end

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
