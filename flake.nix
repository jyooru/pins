{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    nixos-org.url = "github:nixos/nixos-homepage";
  };

  outputs = { self, nixpkgs, utils, ... } @ inputs:
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channelsConfig.allowUnfree = true;
      sharedOverlays = [
        (final: prev: prev.lib.recursiveUpdate prev
          (import ./packages { pkgs = final; }))
      ];

      outputsBuilder = channels:
        let args = { inherit inputs; pkgs = channels.nixpkgs; }; in
        with nixpkgs.lib;
        rec {
          packages = import ./packages args // (genAttrs [
            "hardware"
            "websites"
          ]
            (folder: recurseIntoAttrs (import (./. + "/${folder}") args)));
        };
    };
}
