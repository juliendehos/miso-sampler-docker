{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  /* nurl https://github.com/dmjio/miso */
  misoSource = fetchFromGitHub {
    owner = "dmjio";
    repo = "miso";
    rev = "839b16fda65340f11c003d293f19ff5206720f65";
    hash = "sha256-7KRnEZRbGhbeEuHyJODR3oB1gb4wRXNELW6t4oIUVIg=";
  };

 /* your stuff */
 overrides = self: super: {
   /* el miso */
   miso = super.callCabal2nix "miso" misoSource {};
   /* the sauce */
   app = super.callCabal2nix "app" ./. {};
 };

 /* the magic */
 hPkgs = haskellPackages.override { inherit overrides; };

in

 hPkgs.app
