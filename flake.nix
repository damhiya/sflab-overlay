{
  description = "sflab env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
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
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in {
        inherit overlay;
        devShell = pkgs.mkShell {
          buildInputs = [ (pkgs.mkCoqPackages pkgs.coq_8_15).coq-ordinal ];
        };
      });
}

