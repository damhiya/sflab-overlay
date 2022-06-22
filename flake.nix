{
  description = "sflab env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    ordinal-src.url = "github:minkiminki/Ordinal/main";
    ordinal-src.flake = false;

    sflib-src.url = "github:snu-sf/sflib/master";
    sflib-src.flake = false;

    coq-ext-lib-src.url = "github:snu-sf/coq-ext-lib/poly";
    coq-ext-lib-src.flake = false;

    itree-src.url = "github:DeepSpec/InteractionTrees/4.0.0";
    itree-src.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, ordinal-src, sflib-src, coq-ext-lib-src, itree-src }:
    let
      overlay = self: super: {
        mkCoqPackages = coq:
          let
            callPackage = super.lib.callPackageWith (super // set);
            set = super.mkCoqPackages coq // rec {
              coq-ordinal = callPackage ./coq-ordinal { inherit ordinal-src; };
              coq-sflib = callPackage ./coq-sflib { inherit sflib-src; };
              coq-ext-lib = callPackage ./coq-ext-lib { inherit coq-ext-lib-src; };
              coq-itree = callPackage ./coq-itree { inherit itree-src; };
            };
          in set;
      };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with (pkgs.mkCoqPackages pkgs.coq_8_15); [
            coq-ordinal
            coq-sflib
            coq-ext-lib
            coq-itree
          ];
        };
      }) // {
        overlays.default = overlay;
      };
}
