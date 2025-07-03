{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  /* nurl https://github.com/dmjio/miso */
  misoSource = fetchFromGitHub {
    owner = "haskell-miso";
    repo = "miso";
    rev = "b195befaaaba634805944822e204a5b9003868bf";
    hash = "sha256-j7qKSAT8RCvCGqb5woCnbUT3XbZD3YyU8jLJlMHOSvs=";
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
