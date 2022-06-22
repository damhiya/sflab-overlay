{ stdenv, fetchFromGitHub, coq, coq-ext-lib, paco, itree-src }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-itree";
  version = itree-src.rev;
  src = itree-src;
  nativeBuildInputs = [ coq ];
  buildInputs = [ coq-ext-lib paco ];
  installPhase = ''
    make COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
