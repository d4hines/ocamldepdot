{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:zimbatm/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = with pkgs;
          with ocamlPackages;
          buildDunePackage {
            pname = "ocamldepdot";
            src = ./.;
            version = "0.1";
          };
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/ocamldepdot";
        };

      });
}

