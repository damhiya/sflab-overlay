{ stdenv, fetchFromGitHub, coq, sflib-src }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-sflib";
  version = sflib-src.rev;
  src = sflib-src;
  nativeBuildInputs = [ coq ];
  installPhase = ''
    make -f Makefile.coq COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
