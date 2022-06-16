{ lib, stdenv, fetchFromGitHub, bundlerEnv, ruby, jekyll }:

let
  env = bundlerEnv {
    name = "prev-rust-lang-org-env";
    gemdir = ./.;
    inherit ruby;
  };
in

stdenv.mkDerivation {
  pname = "prev-rust-lang-org";
  version = "20181206";

  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "prev.rust-lang.org";
    rev = "3c8d24f62264c5dd1bd8cb4acc29c2fa2bbc678e";
    hash = "sha256-s4cVLnswM2LjEDyVdjb726FdFGQZTpUzZD+jh+kev8Q=";
  };

  buildPhase = ''
    runHook preBuild

    ${env}/bin/jekyll build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r _site $out    

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://prev.rust-lang.org/";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ jyooru ];
  };
}
