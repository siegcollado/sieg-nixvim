{ inputs, mkPkgs }:
{
  system,
  modules ? [ ],
}:
inputs.nixvim.lib.evalNixvim {
  inherit system;
  modules = [
    { nixpkgs.pkgs = mkPkgs system; }
    (import ../../config)
  ]
  ++ modules;
}
