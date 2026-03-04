{ lib, config, ... }:
{
  config = {
    # mini.base16.palette is the source of truth
    plugins.mini = {
      enable = true;
      modules = {
        base16 = {
          inherit (config) palette;
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

    globals.colors_name = "base16";
  };
}
