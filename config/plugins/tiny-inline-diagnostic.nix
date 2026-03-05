{ config, ... }:
let
  inherit (config.sieg-nixvim.theme) transparent;
in
{
  plugins.tiny-inline-diagnostic = {
    enable = true;
    settings = {
      preset = "powerline";

      transparent_cursorline = transparent;
      tranparent_bg = transparent;

      multilines.enabled = true;
      options = {
        use_icons_from_diagnostics = true;
      };
      override_open_float = true;

      virt_texts.priority = 2048;
      show_source = {
        if_many = true;
        enabled = true;
      };
      show_code = true;
      set_arrow_to_diag_color = true;
    };
  };
}
