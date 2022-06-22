{ stdenv, fetchFromGitHub, coq }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-ordinal";
  version = "dev";
  src = fetchFromGitHub {
    owner = "minkiminki";
    repo = "Ordinal";
    rev = "400831ee977ede030ddf35bf52f1e90418ddf52e";
    sha256 = "sha256-jf16EyLAnKm+42K+gTTHVFJqeOVQfIY2ozbxIs5x5DE=";
  };
  buildInputs = [ coq ];
  installPhase = ''
    make -f Makefile.coq COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
