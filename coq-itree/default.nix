{ stdenv, fetchFromGitHub, coq, coq-ext-lib, paco }:
stdenv.mkDerivation {
  pname = "coq${coq.coq-version}-itree";
  version = "4.0.0";
  src = fetchTarball {
    url = "https://github.com/DeepSpec/InteractionTrees/archive/4.0.0.tar.gz";
    sha256 = "sha256:0h5rhndl8syc24hxq1gch86kj7mpmgr89bxp2hmf28fd7028ijsm";
  };
  buildInputs = [ coq coq-ext-lib paco ];
  installPhase = ''
    make COQMF_COQLIB=$out/lib/coq/${coq.coq-version}/ install
  '';
}
