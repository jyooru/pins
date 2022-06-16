{ lib, stdenv, fetchFromGitHub, hugo }:
stdenv.mkDerivation {
  pname = "syncthing-net";
  version = "20220509";

  src = fetchFromGitHub {
    owner = "syncthing";
    repo = "website";
    rev = "361641177f9230a8f784b3b1fafabe386e721bd5";
    hash = "sha256-Ftup2p6dO7mthe/Wt6mdnZs0zhR8bjAVbHxT08mk/BA=";
  };

  buildInputs = [ hugo ];

  buildPhase = ''
    runHook preBuild

    hugo

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r _site $out

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://rust-lang.github.io/rfcs/";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ jyooru ];
  };
}
