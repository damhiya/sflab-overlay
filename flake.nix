{
  description = "sflab env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = self: super: {
        mkCoqPackages = coq:
          let
            callPackage = super.lib.callPackageWith (super // set);
            set = super.mkCoqPackages coq // rec {
              coq-ordinal = callPackage ./coq-ordinal { };
              coq-sflib = callPackage ./coq-sflib { };
              coq-ext-lib = callPackage ./coq-ext-lib { };
              coq-itree = callPackage ./coq-itree { };
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

