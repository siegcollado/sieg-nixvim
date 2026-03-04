{ lib, config, ... }:
{
  # Define colors option - this sets mini.base16.palette
  options.colors = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {
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
  options.transparent = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable transparent backgrounds (Stylix-compatible)";
  };

  config = {
    # mini.base16.palette is the source of truth
    plugins.mini = {
      enable = true;
      modules = {
        base16 = {
          palette = config.colors;
        };
        colors = { };
      };
    };

    # Read colors from mini.base16.palette for highlight overrides
    highlightOverride = {
      # Floating window borders (general)
      FloatBorder = {
        fg = config.plugins.mini.modules.base16.palette.base01;
      };
    };

    # This just merges in the options without erasing the original settings
    extraConfigLua = ''
      local colors = require('utils.colors')

      colors.override_style("Comment", { italic = true });
      colors.override_style("Function", { italic = true });
      colors.override_style("Keyword", { bold = true });
    '';

    # Transparent plugin - handles transparency via groups
    # This can be disabled by setting config.transparent = false
    # or overridden by Stylix via highlightOverride
    plugins.transparent = lib.mkIf config.transparent {
      enable = true;
      settings = {
        groups = [
          "Normal"
          "NormalNC"
          "Comment"
          "Constant"
          "Special"
          "Identifier"
          "Statement"
          "PreProc"
          "Type"
          "Underlined"
          "Todo"
          "String"
          "Function"
          "Conditional"
          "Repeat"
          "Operator"
          "Structure"
          "LineNr"
          "LineNrAbove"
          "LineNrBelow"
          "NonText"
          "SignColumn"
          "CursorLine"
          "CursorLineNr"
          "StatusLine"
          "StatusLineNC"
          "EndOfBuffer"
        ];
        extra_groups = [
          "NormalFloat"
        ];
      };
    };

    globals.colors_name = "base16";
  };
}
