{ lib, ... }:
{
  plugins.lualine = {
    enable = true;

    settings = {
      options = {
        disabled_filetypes = {
          statusline = [
            "alpha"
            "dashboard"
          ];
        };
        theme = lib.nixvim.mkRaw "_G.utils.lualine.theme.transparent_auto()";
      };
      sections = lib.nixvim.mkRaw "_G.utils.lualine.sections.build().sections";
      inactive_sections = lib.nixvim.mkRaw "_G.utils.lualine.sections.build().inactive_sections";
    };
  };
}
