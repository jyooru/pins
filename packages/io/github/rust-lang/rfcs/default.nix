{ lib, stdenv, fetchFromGitHub, mdbook }:
stdenv.mkDerivation {
  pname = "rust-lang-github-io-rfcs";
  version = "20220527";

  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "rfcs";
    rev = "9925276189646646beffbc4f84ca03b037ff7569";
    hash = "sha256-gKW76TohglTiqyTrOEFRGpFaVlQc9lf2ttg76tL9lfE=";
  };

  buildInputs = [ mdbook ];

  buildPhase = ''
    runHook preBuild

    bash generate-book.sh

    runHook postBuild
  '';

  preInstall = ''
    cp book/404.html book/ipfs-404.html
  '';

  installPhase = ''
    runHook preInstall

    cp -r book $out

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://rust-lang.github.io/rfcs/";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ jyooru ];
  };
}
