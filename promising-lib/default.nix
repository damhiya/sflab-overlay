{ stdenv, coq, sflib, promising-lib-src }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-promising-lib";
  version = promising-lib-src.rev;
  src = promising-lib-src;
  nativeBuildInputs = [ coq ];
  buildInputs = [ sflib ];
  installPhase = ''
    make -f Makefile.coq COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
