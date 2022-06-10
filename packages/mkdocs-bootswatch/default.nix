{ lib
, callPackage
, fetchFromGitHub
, python3
}:

with python3.pkgs;

buildPythonApplication rec {
  pname = "mkdocs-bootswatch";
  version = "1.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "mkdocs";
    repo = pname;
    rev = version;
    hash = "sha256-poV2nv1RJxgawxJuotNsCscft6UDkVwapMXsdfIYqjQ=";
  };

  propagatedBuildInputs = [ mkdocs ];

  doCheck = false;

  pythonImportsCheck = [ "mkdocs_bootswatch" ];

  meta = with lib; {
    description = "MkDocs Bootswatch Themes";
    homepage = "https://github.com/mkdocs/mkdocs-bootswatch/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ jyooru ];
  };
}
