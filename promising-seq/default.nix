{ stdenv, coq, coq-ext-lib, sflib, paco, itree, promising-lib, promising-seq-src }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-promising-seq";
  version = promising-seq-src.rev;
  src = promising-seq-src;
  nativeBuildInputs = [ coq ];
  buildInputs = [ coq-ext-lib sflib paco itree promising-lib ];
  phases = [ "unpackPhase" "buildPhase" "installPhase" ];
  buildPhase = ''
    make build -j20
  '';
  installPhase = ''
    make -f Makefile.coq COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
