{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    nixos-org.url = "github:nixos/nixos-homepage";
  };

  outputs = { self, nixpkgs, utils, ... } @ inputs:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs; in
        with pkgs;
        rec {
          packages = import ./packages { inherit inputs pkgs; };
        };
    };
}
