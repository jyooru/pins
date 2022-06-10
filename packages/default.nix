{ inputs, pkgs }:

with pkgs;

rec {
  mkdocs-bootswatch = callPackage ./mkdocs-bootswatch { };

  r-roms-github-io = callPackage ./io/github/r-roms { inherit mkdocs-bootswatch; };
  rust-lang-github-io-rfcs = callPackage ./io/github/rust-lang/rfcs.nix { };
  yggdrasil-network-github-io = callPackage ./io/github/yggdrasil-network { };

  nixos-org = callPackage ./org/nixos { inherit (inputs) nixos-org; };

  blog-rust-lang-org = callPackage ./org/rust-lang/blog { };
  prev-rust-lang-org = callPackage ./org/rust-lang/prev { };
  doc-rust-lang-org-book = callPackage ./org/rust-lang/doc/book.nix { };
}
