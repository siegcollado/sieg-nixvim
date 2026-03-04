# NixVim

Configs copied from my lazyvim based config with a few adjustments.

```
nix run .
```

## Downstream configuration

Flake usage:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    sieg-nixvim.url = "github:siegcollado/nixvim";
  };

  outputs = { nixpkgs, nixvim, sieg-nixvim, ... }: {
    nixvimConfigurations.myConfig = nixvim.lib.evalNixvim {
      system = "x86_64-linux";
      modules = [
        sieg-nixvim.nixvimModules.default
        {
          sieg-nixvim.theme.transparent = false;
          sieg-nixvim.theme.palette = {
            base00 = "#2e3440";
            base01 = "#3b4252";
          };
        }
      ];
    };
  };
}
```

Home Manager usage:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sieg-nixvim.url = "github:siegcollado/nixvim";
  };

  outputs = { nixpkgs, home-manager, sieg-nixvim, ... }: {
    homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        sieg-nixvim.nixvimModules.default
        {
          programs.nixvim.enable = true;
          sieg-nixvim.theme.transparent = true;
          sieg-nixvim.theme.palette = {
            base00 = "#2e3440";
            base01 = "#3b4252";
          };
        }
      ];
    };
  };
}
```
