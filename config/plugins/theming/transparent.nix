{ lib, config, ... }:
let
  inherit (config.sieg-nixvim.theme) transparent;
in
{
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
