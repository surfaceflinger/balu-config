{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    ,
    } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays;

      nixosConfigurations = {
        x230 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [ ./nixos/hosts/x230 ];
        };
        x280 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [ ./nixos/hosts/x280 ];
        };
        wyse = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [ ./nixos/hosts/wyse ];
        };
      };
    };
}
