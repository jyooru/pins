{ lib, stdenv }:

with builtins;
with lib;

let

  excludedItems = import ./excluded-items.nix;
  filteredItems = filter (item: !(elem (head item.ID) excludedItems))
    (importJSON ./sources.json).body.DownloadItems;

  sha256Overrides = import ./sha256-overrides.nix;
  files = foldl (a: b: a // b) { } ([
    (listToAttrs
      (concatLists (map
        (item: map
          (file: {
            name = "${head item.ID}/${baseNameOf file.URL}";
            value = fetchurl {
              url = file.URL;
              sha256 = let s = file.SHA256; in sha256Overrides.${s} or s;
            };
          })
          item.Files)
        filteredItems)))
  ] ++
  (attrValues
    (mapAttrs
      (id: files: mapAttrs'
        (name: sha256: {
          name = "${id}/${name}";
          value = fetchurl {
            url = "https://download.lenovo.com/pccbbs/mobiles/${name}";
            inherit sha256;
          };
        })
        files)
      (importJSON ./extra-sources.json))));
  fileCommands = concatStringsSep "\n"
    (mapAttrsToList (dest: src: "cp ${src} $out/${dest}") files);

  directories = unique (map dirOf (attrNames files));
  directoryCommands = concatStringsSep "\n"
    (map (dir: "mkdir -p $out/${dir}") directories);
in

stdenv.mkDerivation {
  name = "lenovo-thinkpad-e580-downloads";

  src = ./.;

  dontBuild = true;
  dontPatchELF = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp *.json $out

    ${directoryCommands}
    ${fileCommands}

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://pcsupport.lenovo.com/au/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e580-type-20ks-20kt/downloads/driver-list/";
    license = licenses.unfree;
    maintainers = with maintainers; [ jyooru ];
  };
}
