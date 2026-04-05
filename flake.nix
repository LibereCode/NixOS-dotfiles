{
    description = "Hyperland on Nixos (guide from Tony-btw)";
    inputs = {
        # This is pointing to an unstable release.
        # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
        # i.e. nixos-24.11
        # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim"; # unstable

            inputs.nixpkgs.follows = "nixpkgs"; # not recommended ?
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, nixvim, ... }: {
        # NOTE: change the hostname (here: 'virtualice')
        nixosConfigurations.virtualice = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux"; # x86_64-linux not need to specify
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.nixnomo = import ./home.nix;
                        backupFileExtension = "old";
                    };
                }
                nixvim.nixosModules.nixvim
            ];
        };
    };
}
# NOTE: to add a module:
#   1.  input.<bar>.url = "github:<foo>/<bar>";
#   2.  outputs = inputs@{ stuff, shit, <bar>, ... }:
#   3.  outputs....modules = [ <choose below> ]
#       <bar>.nixosModules.<something>  # nixos module
#       <bar>.homeModules.<something>  # home-manager module

