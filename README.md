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

Minimal downstream usage with overlays handled for you:

```nix
myNixvim = sieg-nixvim.lib.mkNixvimConfig {
  system = pkgs.system;
  modules = [
    {
      sieg-nixvim.theme.palette = config.lib.stylix.colors.withHashtag;
      sieg-nixvim.theme.transparent = config.stylix.opacity.terminal < 1.0;
    }
  ];
};

home.packages = [ myNixvim.config.build.package ];
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

### Stylix integration

When using Stylix, disable its Nixvim target to avoid conflicting theme settings,
then pass palette/transparent values to sieg-nixvim:

```nix
stylix.targets.nixvim.enable = false;

sieg-nixvim.theme.palette = config.lib.stylix.colors.withHashtag;
sieg-nixvim.theme.transparent = config.stylix.opacity.terminal < 1.0;
```

If you build your config with `evalNixvim`, pass the overrides directly:

```nix
myNixvim = nixvim.lib.evalNixvim {
  system = pkgs.system;
  modules = [
    sieg-nixvim.nixvimModules.default
    {
      sieg-nixvim.theme.palette = config.lib.stylix.colors.withHashtag;
      sieg-nixvim.theme.transparent = config.stylix.opacity.terminal < 1.0;
    }
  ];
};
```
