{ config, ... }:
{
  config = {
    # mini.base16.palette is the source of truth
    colorschemes.mini-base16 = {
      enable = true;
      settings = {
        inherit (config.sieg-nixvim.theme) palette;
      };
    };

    # Read colors from mini.base16.palette for highlight overrides
    highlightOverride = {
      # Floating window borders (general)
      FloatBorder = {
        # TODO: dont call from this setting directly.
        fg = config.colorschemes.mini-base16.settings.palette.base01;
      };
    };

    # This just merges in the options without erasing the original settings
    extraConfigLua = ''
      local colors = _G.utils.colors

      colors.override_style("Comment", { italic = true });
      colors.override_style("Function", { italic = true });
      colors.override_style("Keyword", { bold = true });
    '';

  };
}
