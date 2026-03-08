{ lib, config, ... }:
let
  inherit (config.sieg-nixvim.theme) transparent;
in
{
  # Keep this global in sync with the theme option.
  # transparent.nvim reads vim.g.transparent_enabled on startup; without this,
  # transparency can default to off until :TransparentToggle is run manually.
  globals.transparent_enabled = transparent;

  plugins.transparent = lib.mkIf transparent {
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
      ];
      extra_groups = [
        "NormalFloat"
        "StatusLine"
        "WinSeparator"

        "DiagnosticSignWarn"
        "DiagnosticSignOk"
        "DiagnosticSignError"
        "DiagnosticSignInfo"
      ];
    };
  };

}
