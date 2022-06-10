{ inputs, pkgs }:

with pkgs;

rec {
  mkdocs-bootswatch = callPackage ./mkdocs-bootswatch { };

  r-roms-github-io = callPackage ./io/github/r-roms { inherit mkdocs-bootswatch; };
  yggdrasil-network-github-io = callPackage ./io/github/yggdrasil-network { };

  nixos-org = callPackage ./org/nixos { inherit (inputs) nixos-org; };

  doc-rust-lang-org-book = callPackage ./org/rust-lang/doc/book.nix { };
}
