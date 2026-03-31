{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" ];
      flake = {
        nixosConfigurations = {
          redice = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
	      ./configuration.nix

              inputs.home-manager.nixosModules.home-manager

              # Add mango nixos module
              inputs.mango.nixosModules.mango
              {
                programs.mango.enable = true;
              }
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "backup";
                  users."kashnomo".imports = [
		    ./home.nix
                    ]
                    ++ [
                      # Add mango hm module
                      inputs.mango.hmModules.mango
                    ];
                };
              }
            ];
          };
        };
      };
    };
}
