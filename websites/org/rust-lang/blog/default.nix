{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
}:

let
  version = "20220609";

  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "blog.rust-lang.org";
    rev = "4842952506a1ac296f16fe59754d4142f9cd74dd";
    hash = "sha256-Pxfxt6Ix62IUWUN6UcdrhWxRqTauwcKrFav6OtGN5p0=";
  };

  meta = with lib; {
    homepage = "https://github.com/rust-lang/blog.rust-lang.org";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ jyooru ];
  };

  generator = rustPlatform.buildRustPackage rec {
    pname = "blog";
    inherit version src meta;
    cargoSha256 = "sha256-VSJXl5oQXixwqMi33B2oz0St/f6e9duP28tgBy8m7F0=";
  };
in

stdenv.mkDerivation {
  pname = "blog-rust-lang-org";
  inherit version src meta;

  buildInputs = [ generator ];

  buildPhase = ''
    runHook preBuild

    blog 

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r site $out

    runHook postInstall
  '';

  passthru = { inherit generator; };
}

