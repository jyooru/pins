{ inputs, pkgs }:

with pkgs;

rec {
  mkdocs-bootswatch = callPackage ./mkdocs-bootswatch { };

  nixos-org = callPackage ./org/nixos { inherit (inputs) nixos-org; };

  r-roms-github-io = callPackage ./io/github/r-roms { inherit mkdocs-bootswatch; };

  yggdrasil-network-github-io = callPackage ./io/github/yggdrasil-network { };
}
