{
  description = "sflab env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    coq-ext-lib-src.url = "github:snu-sf/coq-ext-lib/poly";
    coq-ext-lib-src.flake = false;

    ordinal-src.url = "github:minkiminki/Ordinal/main";
    ordinal-src.flake = false;

    sflib-src.url = "github:snu-sf/sflib/master";
    sflib-src.flake = false;

    itree-src.url = "github:DeepSpec/InteractionTrees/4.0.0";
    itree-src.flake = false;

    promising-lib-src.url = "github:snu-sf/promising-lib/8.15";
    promising-lib-src.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, coq-ext-lib-src, ordinal-src, sflib-src, itree-src, promising-lib-src }:
    let
      overlay = self: super: {
        mkCoqPackages = coq:
          let
            callPackage = super.lib.callPackageWith (super // set);
            set = super.mkCoqPackages coq // rec {
              ordinal = callPackage ./ordinal { inherit ordinal-src; };
              sflib = callPackage ./sflib { inherit sflib-src; };
              coq-ext-lib = callPackage ./coq-ext-lib { inherit coq-ext-lib-src; };
              itree = callPackage ./itree { inherit itree-src; };
              promising-lib = callPackage ./promising-lib { inherit promising-lib-src; };
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
            coq
            ordinal
            sflib
            coq-ext-lib
            itree
            promising-lib
          ];
        };
      }) // {
        overlays.default = overlay;
      };
}
