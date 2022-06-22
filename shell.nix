{ pkgs }:
let
  mkBuildInputs = coq:
    let
      super = pkgs.mkCoqPackages coq;
      callPackage = pkgs.lib.callPackageWith (pkgs // set);
      set = rec {
        inherit coq;
        ocaml = coq.ocaml;
        menhir = coq.ocamlPackages.menhir;
        menhirLib = coq.ocamlPackages.menhirLib;
        coq-ext-lib =
          callPackage super.coq-ext-lib.override { version = "0.11.3"; };
        paco = callPackage super.paco.override { version = "4.1.1"; };
        ITree = callPackage super.ITree.override { version = "3.2.0"; };
        stdpp = callPackage super.stdpp.override { version = "1.5.0"; };
        iris = callPackage super.iris.override { version = "3.4.0"; };
        flocq = super.flocq;
        coq-menhirlib = callPackage ./coq-menhirlib { };
        compcert = (super.compcert.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ coq-menhirlib ];
          configurePhase = ''
            ./configure -clightgen \
            -prefix $out \
            -coqdevdir $lib/lib/coq/${coq.coq-version}/user-contrib/compcert/ \
            -toolprefix ${pkgs.stdenv.cc}/bin/ \
            -use-external-Flocq \
            -use-external-MenhirLib \
            ${if pkgs.stdenv.isDarwin then "x86_64-macosx" else "x86_64-linux"}
          '';
        })).override {
          version = "3.9";
          inherit flocq;
        };
        ordinal = callPackage ./coq-ordinal { };
      };
    in pkgs.lib.attrValues set;
in pkgs.mkShell {
  nativeBuildInputs = [ pkgs.ocamlPackages.ocamlbuild ];
  buildInputs = mkBuildInputs pkgs.coq_8_13;
}
