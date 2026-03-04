{ lib, ... }:
{
  plugins.mini = {
    enable = true;
    modules = {
      base16 = {
        palette = {
          base00 = "#2e3440";
          base01 = "#3b4252";
          base02 = "#434c5e";
          base03 = "#4c566a";
          base04 = "#d8dee9";
          base05 = "#e5e9f0";
          base06 = "#eceff4";
          base07 = "#8fbcbb";
          base08 = "#bf616a";
          base09 = "#d08770";
          base0A = "#ebcb8b";
          base0B = "#a3be8c";
          base0C = "#88c0d0";
          base0D = "#81a1c1";
          base0E = "#b48ead";
          base0F = "#5e81ac";
        };
      };
      colors = { };
    };
  };

  globals.colors_name = "base16";

  plugins.transparent = {
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
        "NonText"
        "SignColumn"
        "CursorLine"
        "CursorLineNr"
        "StatusLine"
        "StatusLineNC"
        "EndOfBuffer"
        # TODO: Add transparency overrides to the plugins themselves.
        # "NormalFloat" # plugins which have float panel such as Lazy, Mason, LspInfo
        # "NvimTreeNormal" # NvimTree
        # "WhichKeyIcon"
      ];
      extra_groups = [
        "NormalFloat" # plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal" # NvimTree
        "WhichKeyIcon"
      ];
    };
  };

  # TODO: make me work!
  #
  # plugins.mini-colors = {
  #   enable = true;
  #   autoLoad = true;
  # };
  #
  # autoCmd = [
  #   {
  #     event = "ColorScheme";
  #     callback = lib.nixvim.mkRaw ''
  #       function()
  #         local colors = require("mini.colors")
  #
  #         colors
  #           .get_colorscheme()
  #           :resolve_links()
  #           :add_transparency({
  #             general = true,
  #             float = true,
  #             statuscolumn = true,
  #             statusline = true,
  #             tabline = true,
  #             winbar = true,
  #           })
  #           :apply()
  #       end
  #     '';
  #   }
  # ];

  # extraConfigLua = ''
  #   vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
  # '';
}
