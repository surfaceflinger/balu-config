{
  description = "nat's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    limine = {
      url = "github:czapek1337/limine-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , limine
    ,
    }:
      with nixpkgs; {
        nixosConfigurations = {
          boiler = lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              limine.nixosModule
              ./hosts/boiler
              ./hosts/common.nix
              ./hosts/common-pc.nix
            ];
          };
        };
      };
}
