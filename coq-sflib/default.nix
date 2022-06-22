{ stdenv, fetchFromGitHub, coq }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-sflib";
  version = "dev";
  src = fetchFromGitHub {
    owner = "snu-sf";
    repo = "sflib";
    rev = "2203ecc62fef14c2204f10329f2cc85f5bc4f108";
    sha256 = "sha256-S0b5YxTu5uJaLIntkioxdqVjDbimupw5/pyIV+Z6M7M=";
  };
  buildInputs = [ coq ];
  installPhase = ''
    make -f Makefile.coq COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
