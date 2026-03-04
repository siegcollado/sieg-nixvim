# TODO: Remove this file after porting all plugins to snacks.nvim picker
{ config, ... }:
{
  plugins.telescope.enable = true;

  # Telescope border colors from theme
  highlightOverride = {
    TelescopeBorder = {
      fg = config.plugins.mini.modules.base16.palette.base01;
    };
    TelescopePromptBorder = {
      fg = config.plugins.mini.modules.base16.palette.base01;
    };
  };
}
