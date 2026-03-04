# TODO: Remove this file after porting all plugins to snacks.nvim picker
{ config, ... }:
{
  plugins.telescope.enable = true;

  # Telescope border colors from theme
  highlightOverride = {
    TelescopeBorder = {
      fg = config.colorschemes.mini-base16.settings.palette.base01;
    };
    TelescopePromptBorder = {
      fg = config.colorschemes.mini-base16.settings.palette.base01;
    };
  };
}
