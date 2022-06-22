{ stdenv, fetchFromGitHub, coq }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-coq-ext-lib";
  version = "dev";
  src = fetchFromGitHub {
    owner = "snu-sf";
    repo = "coq-ext-lib";
    rev = "968fb49a1f1044adf87f8e427cbe2d83d525d37d";
    sha256 = "sha256-tgnktKgP7sx1mkh1QTjtamQCIt1L374Fdt7YYYB2+AE=";
  };
  buildInputs = [ coq ];
  buildPhase = ''
    make theories
  '';
  installPhase = ''
    make COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
