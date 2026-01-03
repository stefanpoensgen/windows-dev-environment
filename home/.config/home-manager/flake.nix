{
  description = "Home Manager configuration of stefan";
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Alte nixpkgs Version für PhpStorm
    nixpkgs-old.url = "github:NixOS/nixpkgs/e6f23dc08d3624daab7094b701aa3954923c6bbb";
  };
  outputs = { nixpkgs, home-manager, nixpkgs-old, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-old = import nixpkgs-old {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      homeConfigurations."stefan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        
        extraSpecialArgs = {
          inherit pkgs-old;
        };
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
