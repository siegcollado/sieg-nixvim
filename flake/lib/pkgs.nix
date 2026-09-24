{
  inputs,
  lib,
  self,
}:
system:
import inputs.nixpkgs {
  inherit system;
  overlays = [ self.overlays.default ];
  config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot-language-server"
      "neotest-vitest"
      "transparent.nvim"
    ];
}
