{
  inputs,
  lib,
  self,
  config,
  withSystem,
  ...
}:
let
  mkNixvimConfig =
    {
      system,
      modules ? [ ],
    }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };
    in
    inputs.nixvim.lib.evalNixvim {
      inherit system;
      modules = [
        { nixpkgs.pkgs = pkgs; }
        (import ../config)
      ]
      ++ modules;
    };
in
{
  imports = [
    ./overlays.nix
  ];

  flake = {
    nixvimModules.default = ../config;
    lib = {
      inherit mkNixvimConfig;
    };
    nixvimConfigurations = lib.genAttrs config.systems (
      system: withSystem system ({ ... }: mkNixvimConfig { inherit system; })
    );
  };

  perSystem =
    { system, ... }:
    let
      # Create pkgs with our custom overlay
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          self.overlays.default
        ];
      };

      nixvimLib = inputs.nixvim.lib.${system};
      nixvim' = inputs.nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit pkgs; # Use our custom pkgs with the overlay
        module = import ../config;
      };
      nvim = nixvim'.makeNixvimWithModule nixvimModule;
    in
    {
      checks = {
        # Run `nix flake check .` to verify that your config is not broken
        default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
      };

      packages = {
        # Lets you run `nix run .` to start nixvim
        default = nvim;

        # no-transparent = nixvim'.makeNixvimWithModule {
        #   inherit pkgs;
        #   module = [
        #     ../config
        #     { sieg-nixvim.theme.transparent = false; }
        #   ];
        # }.config.build.package;
      };

      devShells = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [ statix ];
        };
      };
    };
}
