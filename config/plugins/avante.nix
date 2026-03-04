{ lib, ... }:
{
  plugins.avante = {
    enable = true;
    settings = {
      provider = "copilot";
      auto_suggestions_provider = "copilot";
      suggestion = {
        debounce = 1500;
        throttle = 1500;
      };
      input = {
        provider = "snacks";
      };
      windows = {
        width = 40;
        sidebar_header = {
          enabled = true;
          align = "right";
          rounded = false;
        };
        input = {
          height = 12;
        };
      };
      selection = {
        enabled = true;
        hint_display = "none";
      };
      behaviour = {
        auto_set_keymaps = false;
      };
      mappings = {
        sidebar = {
          close_from_input = lib.nixvim.lua.toLuaObject {
            normal = "<Esc>";
            insert = "q";
          };
        };
      };
    };
  };

}
