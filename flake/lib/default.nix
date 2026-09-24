{
  inputs,
  lib,
  self,
}:
let
  mkPkgs = import ./pkgs.nix { inherit inputs lib self; };
in
{
  inherit mkPkgs;
  mkNixvimConfig = import ./nixvim-config.nix { inherit inputs mkPkgs; };
  mkNvimShell = import ./nvim-shell.nix { inherit lib; };
}
