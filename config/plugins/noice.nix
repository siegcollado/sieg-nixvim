{ lib, config, ... }:
{
  plugins = {
    noice = {
      enable = true;
      settings = {
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
        };
        routes = [
          {
            filter = {
              event = "msg_show";
              any = [
                { find = "%d+L, %d+B"; }
                { find = "; after #%d+"; }
                { find = "; before #%d+"; }
              ];
            };
            view = "mini";
          }
        ];
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
        };
        # cmdline = {
        #   enabled = true;
        #   format = {
        #     cmdline = {
        #       icon = " ";
        # hl_group = "DiagnosticInfo";
        # firstc = false;
        # };
        # search_down = {
        #   icon = " ";
        #   hl_group = "DiagnosticWarn";
        # };
        # search_up = {
        #   icon = " ";
        #   hl_group = "DiagnosticWarn";
        # };
        # help = {
        #   icon = "? ";
        #   hl_group = "DiagnosticQuestion";
        # };
        #   };
        # };
      };
    };
    nui.enable = true;
    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>sn";
        desc = "Noice Keymaps (which-key)";
      }
    ];

    # Add Noice highlight groups to transparent plugin
    transparent = lib.mkIf config.sieg-nixvim.theme.transparent {
      settings.extra_groups = [
        "NoiceMini"
        "NoiceLspProgressTitle"
        "NoiceLspProgressClient"
        "NoiceLspProgressSpinner"
      ];
    };
  };

  # Noice border colors from theme
  highlightOverride = {
    # NoicePopupBorder = {
    #   fg = config.colorschemes.mini-base16.settings.palette.base01;
    # };
    # NoiceCmdlinePopupBorder = {
    #   fg = config.colorschemes.mini-base16.settings.palette.base01;
    # };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>snl";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("last") end'';
      options.desc = "Noice Last";
    }
    {
      mode = "n";
      key = "<leader>snh";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("history") end'';
      options.desc = "Noice History";
    }
    {
      mode = "n";
      key = "<leader>sna";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("all") end'';
      options.desc = "Noice All";
    }
    {
      mode = "n";
      key = "<leader>snd";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("dismiss") end'';
      options.desc = "Dismiss All";
    }
    {
      mode = "n";
      key = "<leader>snt";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("pick") end'';
      options.desc = "Noice Picker";
    }
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<c-f>";
      action = lib.nixvim.mkRaw ''
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end
      '';
      options = {
        silent = true;
        expr = true;
        desc = "Scroll Forward";
      };
    }
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<c-b>";
      action = lib.nixvim.mkRaw ''
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end
      '';
      options = {
        silent = true;
        expr = true;
        desc = "Scroll Backward";
      };
    }
    {
      mode = "c";
      key = "<s-enter>";
      action = lib.nixvim.mkRaw ''function() require("noice").redirect(vim.fn.getcmdline()) end'';
      options.desc = "Redirect Cmdline";
    }
  ];
}
