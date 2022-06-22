{
  description = "sflab env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    overlay = self: super: 
    {
      coq-ordinal = callPackage ./coq-ordinal { };
    };
  };
}

