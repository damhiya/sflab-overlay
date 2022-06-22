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
          buildInputs = [ (pkgs.mkCoqPackages pkgs.coq_8_15).coq-ordinal ];
        };
      }) // {
        overlays.default = overlay;
      };
}

