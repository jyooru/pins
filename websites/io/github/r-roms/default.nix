{ lib, stdenv, fetchFromGitHub, python3 }:

stdenv.mkDerivation {
  pname = "r-roms-github-io";
  version = "20220527";

  src = fetchFromGitHub {
    owner = "r-roms";
    repo = "r-roms-megathread";
    rev = "13d77ef4cb04b55e1154bb18fc2b42b22037b91e";
    hash = "sha256-xhVzzeVJASmEAdjJ3RTD4lLMnqOdKerdRVRERN70S5k=";
  };

  nativeBuildInputs = with python3.pkgs; [
    mkdocs
    mkdocs-bootswatch
  ];

  buildPhase = ''
    runHook preBuild

    mkdocs build 

    runHook postBuild
  '';

  preInstall = ''
    cp site/404.html site/ipfs-404.html
  '';

  installPhase = ''
    runHook preInstall

    cp -r site $out

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://r-roms.github.io/";
    maintainers = with maintainers; [ jyooru ];
  };
}
