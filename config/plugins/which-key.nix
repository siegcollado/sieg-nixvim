{ lib, config, ... }:
{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      icons = {
        mappings = false;
      };
      spec = [
        {
          __unkeyed-1 = "<leader>?";
          desc = "Buffer Keymaps (which-key)";
        }
        {
          __unkeyed-1 = "<leader>a";
          group = "+ai";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "+buffer";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "+code";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "+debug";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "+file/find";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "+git";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>p";
          group = "+project";
        }
        {
          __unkeyed-1 = "<leader>q";
          group = "+quit/session";
        }
        {
          __unkeyed-1 = "<leader>r";
          group = "+refactor";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "+search";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "+test";
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "+ui";
        }
        {
          __unkeyed-1 = "<leader>w";
          group = "+windows";
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "+diagnostics/quickfix";
        }
        {
          __unkeyed-1 = "<leader><tab>";
          group = "+tabs";
        }
      ];
    };
  };

  # Add WhichKey highlight groups to transparent plugin
  plugins.transparent = lib.mkIf config.transparent {
    settings.extra_groups = [
      "WhichKeySeparator"
      "WhichKeyIcon"
    ];
  };

  # WhichKey border colors from theme
  highlightOverride = {
    WhichKeyBorder = {
      fg = config.colorschemes.mini-base16.settings.palette.base01;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>?";
      action = lib.nixvim.mkRaw ''
        function()
          require("which-key").show({ global = false })
        end
      '';
      options = {
        desc = "Buffer Keymaps (which-key)";
      };
    }
  ];
}
