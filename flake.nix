{
  description = "A Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    exrc-nvim = {
      url = "github:jedrzejboczar/exrc.nvim";
      flake = false;
    };
    agentic-nvim = {
      url = "github:carlos-algms/agentic.nvim";
      flake = false;
    };
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          # Create pkgs with our custom overlay
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (final: prev: {
                vimPlugins = prev.vimPlugins // {
                  exrc-nvim = prev.vimUtils.buildVimPlugin {
                    pname = "exrc.nvim";
                    version = inputs.exrc-nvim.shortRev or "unknown";
                    src = inputs.exrc-nvim;
                  };
                  agentic-nvim = prev.vimUtils.buildVimPlugin {
                    pname = "agentic.nvim";
                    version = inputs.agentic-nvim.shortRev or "unknown";
                    src = inputs.agentic-nvim;
                    # Disable all checks - plugin has test files with missing deps
                    doCheck = false;
                    dontCheck = true;
                  };
                };
              })
            ];
          };

          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs; # Use our custom pkgs with the overlay
            module = import ./config;
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
          };

          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [ statix ];
            };
          };
        };
    };
}
