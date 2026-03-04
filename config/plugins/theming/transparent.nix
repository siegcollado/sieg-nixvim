{ lib, config, ... }:
{
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
      ];
      extra_groups = [
        "NormalFloat"
        "StatusLine"
      ];
    };
  };

}
