{ pkgs, ... }:

with pkgs;

{
  lenovo-thinkpad-e580-downloads = callPackage ./lenovo/thinkpad/e580/downloads { };
}
