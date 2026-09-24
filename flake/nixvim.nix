{
  siegLib,
  lib,
  config,
  ...
}:
{
  flake = {
    nixvimModules.default = ../config;
    nixvimConfigurations = lib.genAttrs config.systems (
      system: siegLib.mkNixvimConfig { inherit system; }
    );
  };
}
