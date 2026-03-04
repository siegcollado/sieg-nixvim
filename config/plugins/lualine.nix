{ lib, ... }:
{
  plugins.lualine = {
    enable = true;

    settings = {
      extensions = [
        {
          sections = {
            lualine_c = lib.nixvim.mkRaw ''require("lualine.extensions.neo-tree").sections.lualine_a'';
          };
          filetypes = [ "neo-tree" ];
        }
      ];
      options = {
        disabled_filetypes = {
          statusline = [
            "alpha"
            "dashboard"
          ];
        };
        theme = lib.nixvim.mkRaw ''require("utils.lualine.theme").transparent_auto()'';
      };
      sections = lib.nixvim.mkRaw ''require("utils.lualine.sections").build().sections'';
      inactive_sections = lib.nixvim.mkRaw ''require("utils.lualine.sections").build().inactive_sections'';
    };
  };
}
