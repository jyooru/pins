{ lib, stdenv, fetchFromGitHub, bundlerEnv, ruby, jekyll }:

let
  env = bundlerEnv {
    name = "yggdrasil-network-github-io-env";
    gemdir = ./.;
    inherit ruby;
  };
in

stdenv.mkDerivation {
  pname = "yggdrasil-network-github-io";
  version = "20220529";

  src = fetchFromGitHub {
    owner = "yggdrasil-network";
    repo = "yggdrasil-network.github.io";
    rev = "7320051d62fa0757b7f9e5e648b479a08ed1aa7c";
    hash = "sha256-oZ7oADrq7gZhvj7iMq/v2B6iPbM/1NiHOzfocskKGC8=";
  };

  LC_ALL = "C.UTF-8";

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
    homepage = "https://yggdrasil-network.github.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
