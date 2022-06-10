{ inputs, pkgs }:

with pkgs;

{
  nixos-org = callPackage ./org/nixos { inherit (inputs) nixos-org; };
}
