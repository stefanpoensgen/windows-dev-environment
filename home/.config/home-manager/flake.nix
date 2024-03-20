{
  description = "Home Manager configuration of stefan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	devenv.url = "github:cachix/devenv/v0.6.3";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
	jetbrains = {
      url = "github:shyim/jetbrains-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    froshpkgs = {
      url = "github:FriendsOfShopware/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, devenv, jetbrains, froshpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."stefan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
		
		extraSpecialArgs = {
			jetbrains = jetbrains;
			devenv = devenv;
			froshpkgs = froshpkgs;
		};

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
