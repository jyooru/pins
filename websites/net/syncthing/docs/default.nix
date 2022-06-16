{ lib, stdenv, fetchFromGitHub, python3 }:
stdenv.mkDerivation {
  pname = "docs-syncthing-net";
  version = "20220609";

  src = fetchFromGitHub {
    owner = "syncthing";
    repo = "docs";
    rev = "2cf6093e8491fc78db5527740cfff224625fa485";
    hash = "sha256-HbheoGAUqE1xg/lVvc9OjecOzOKJbUwULcXkI9V7PKI=";
  };

  buildInputs = [ python3.pkgs.sphinx ];

  buildPhase = ''
    runHook preBuild

    make html

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r _build/html $out

    runHook postInstall
  '';

  meta = with lib; {
    homepage = " https://docs.syncthing.net/";
    maintainers = with maintainers; [ jyooru ];
  };
}

