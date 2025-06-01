{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  /* nurl https://github.com/dmjio/miso */
  misoSource = fetchFromGitHub {
    owner = "dmjio";
    repo = "miso";
    rev = "05bd9559d03bfa105e11116581d9b2ece66911c6";
    hash = "sha256-eD1j1NeLzg5NLPm0n7SXChyhofOfOowA/WEwhCXDQEA=";
  };

 /* your stuff */
 overrides = self: super: {
   /* el miso */
   miso = super.callCabal2nixWithOptions "miso" misoSource "-ftemplate-haskell" {};
   /* the sauce */
   app = super.callCabal2nix "app" ./. {};
 };

 /* the magic */
 hPkgs = haskellPackages.override { inherit overrides; };

in

 hPkgs.app
