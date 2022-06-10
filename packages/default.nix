{ inputs, pkgs }:

with pkgs;

{
  nixos-org = callPackage ./org/nixos { inherit (inputs) nixos-org; };

  yggdrasil-network-github-io = callPackage ./io/github/yggdrasil-network { };
}
