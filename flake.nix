# flake.nix
{
  description = "gomazarashi.github.io development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    tola.url = "github:tola-ssg/tola-ssg/v0.7.1";
  };

  outputs = { self, nixpkgs, flake-utils, tola }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.typst
            pkgs.just
            pkgs.git
            pkgs.ripgrep
            pkgs.curl
            pkgs.alejandra
            tola.packages.${system}.default
          ];

          shellHook = ''
            echo "devShell ready"
            echo "available commands: just build | just serve | just clean"
          '';
        };

        formatter = pkgs.alejandra;
      });
}
