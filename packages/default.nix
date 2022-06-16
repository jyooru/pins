{ pkgs, ... }:

with pkgs;

{
  python3.pkgs.mkdocs-bootswatch = callPackage ./development/python-modules/mkdocs-bootswatch { };
}
