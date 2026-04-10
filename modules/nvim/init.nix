{ lib, pkgs, ... }:

{
	imports = [
	./maps.nix
	./opts.nix
	./plugs.nix
	];

	programs = {
        neovim = {
            enable = true;
            defaultEditor = true; # VISUAL=EDITOR=nvim
            extraLuaPackages = luaPkgs: with luaPkgs; [luautf8 ];

			# nvimLateInit
            initLua = lib.mkAfter '' 
					-- later
			'';

            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
        };
	};
}
