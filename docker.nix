# nix-build docker.nix
# docker load < result
# docker run --rm -it -p 3000:3000 app-server:latest

{ pkgs ? import <nixpkgs> {} }:

let

  app = pkgs.callPackage ./app.nix {};

  entrypoint = pkgs.writeScript "entrypoint.sh" ''
    #!${pkgs.stdenv.shell}
    $@
  '';


in pkgs.dockerTools.buildLayeredImage {
  name = "app-server";
  tag = "latest";
  created = "now";
  contents = [ "${app}" ];
  config = {
    Entrypoint = [ entrypoint ];
    Cmd = [ "${pkgs.static-web-server}/bin/static-web-server -p 3000 -d ${app}/public/" ];
  };

}

