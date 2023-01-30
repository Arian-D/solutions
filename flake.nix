{
  description = "My write-up website";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay";

  outputs = { self, nixpkgs, flake-utils, emacs-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ emacs-overlay.overlays.package ];
        };
        emacsWithOxHugo = pkgs.emacsWithPackages (epkgs: [ epkgs.ox-hugo ]);
        deps = [ pkgs.hugo emacsWithOxHugo ];
      in rec {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "writeups";
          version = "0.0.1";
          dontFixup = true;
          src = ./.;
          installPhase = "
            cp -r public $out
          ";
          nativeBuildInputs = deps;
        };
      });
}
