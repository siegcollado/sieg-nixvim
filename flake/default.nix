{
  inputs,
  lib,
  self,
  ...
}:
let
  siegLib = import ./lib { inherit inputs lib self; };
in
{
  imports = [
    ./overlays.nix
    ./nixvim.nix
    ./packages.nix
    ./shells.nix
  ];

  _module.args = { inherit siegLib; };

  flake.lib = siegLib;
}
