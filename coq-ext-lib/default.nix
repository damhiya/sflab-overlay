{ stdenv, fetchFromGitHub, coq, coq-ext-lib-src }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-coq-ext-lib";
  version = coq-ext-lib-src.rev;
  src = coq-ext-lib-src;
  nativeBuildInputs = [ coq ];
  buildPhase = ''
    make theories
  '';
  installPhase = ''
    make COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
