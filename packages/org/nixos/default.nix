{ lib, stdenv, nixos-org, system }:

with lib;

stdenv.mkDerivation {
  pname = "nixos-org";
  version = toString nixos-org.lastModifiedDate;

  src = nixos-org.defaultPackage.${system};

  dontBuild = true;

  preInstall = ''
    cp 404.html ipfs-404.html
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -Lr . $out    

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/NixOS/nixos-homepage";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
