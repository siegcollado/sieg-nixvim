{ lib, ... }:
{
  imports = [
    ./mini-base16.nix
    ./transparent.nix
  ];

  options = {
    palette = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        # just do nord
        base00 = "#2e3440"; # Default background
        base01 = "#3b4252"; # Lighter background / dark grey
        base02 = "#434c5e"; # Selection background
        base03 = "#4c566a"; # Comments / dimmed
        base04 = "#d8dee9"; # Dark foreground
        base05 = "#e5e9f0"; # Default foreground
        base06 = "#eceff4"; # Light foreground
        base07 = "#8fbcbb"; # Light background
        base08 = "#bf616a"; # Variables (red)
        base09 = "#d08770"; # Integers (orange)
        base0A = "#ebcb8b"; # Classes (yellow)
        base0B = "#a3be8c"; # Strings (green)
        base0C = "#88c0d0"; # Support (cyan)
        base0D = "#81a1c1"; # Functions (blue)
        base0E = "#b48ead"; # Keywords (magenta)
        base0F = "#5e81ac"; # Deprecated
      };
      description = "Base16 color palette - sets mini.base16.palette";
    };

    # Stylix-compatible transparency option
    transparent = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable transparent background";
    };
  };
}
