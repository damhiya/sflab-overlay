{ stdenv, fetchFromGitHub, coq }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-ordinal";
  version = "0.5.0";
  src = fetchFromGitHub {
    owner = "minkiminki";
    repo = "Ordinal";
    rev = "7d82d73db3fa248d4d19686fc2eff9836f684302";
    sha256 = "Jq0LnR7TgRVcPqh8Ha6tIIK3KfRUgmzA9EhxeySgPnM=";
  };
  buildInputs = [ coq ];
  installPhase = ''
    make -f Makefile.coq COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
