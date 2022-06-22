{
  description = "sflab env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    overlay = self: super: {
      mkCoqPackages = coq:
        let
          callPackage = super.lib.callPackageWith (super // set);
          set = super.mkCoqPackages coq // rec {
            coq-ordinal = callPackage ./coq-ordinal { };
          };
        in super.lib.attrValues set;
    };
  };
}

