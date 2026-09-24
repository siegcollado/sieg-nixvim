{ inputs, siegLib, ... }:
{
  perSystem =
    { system, ... }:
    let
      # Use our custom pkgs with the overlay
      pkgs = siegLib.mkPkgs system;

      nixvimLib = inputs.nixvim.lib.${system};
      nixvim' = inputs.nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit pkgs;
        module = import ../config;
      };
    in
    {
      checks = {
        # Run `nix flake check .` to verify that your config is not broken
        default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
      };

      packages = {
        # Lets you run `nix run .` to start nixvim
        default = nixvim'.makeNixvimWithModule nixvimModule;

        # no-transparent = nixvim'.makeNixvimWithModule {
        #   inherit pkgs;
        #   module = [
        #     ../config
        #     { sieg-nixvim.theme.transparent = false; }
        #   ];
        # }.config.build.package;
      };
    };
}
