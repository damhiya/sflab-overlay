{ stdenv, fetchFromGitHub, coq, ordinal-src }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-ordinal";
  version = ordinal-src.rev;
  src = ordinal-src;
  nativeBuildInputs = [ coq ];
  installPhase = ''
    make -f Makefile.coq COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
