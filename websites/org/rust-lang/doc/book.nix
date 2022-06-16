{ lib, stdenv, fetchFromGitHub, mdbook }:
stdenv.mkDerivation {
  pname = "doc-rust-lang-org-book";
  version = "20220609";

  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "book";
    rev = "3f3f6ed8378c352adec39188f851d2b04d211768";
    hash = "sha256-Lbxk6ErXX7Jm1/mmU1cb/qr3sU2pSWcNBZQP0wAw5FY=";
  };

  buildInputs = [ mdbook ];

  buildPhase = ''
    runHook preBuild

    mdbook build

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
    homepage = "https://doc.rust-lang.org/book/";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ jyooru ];
  };
}
