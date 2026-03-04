{ lib, config, ... }:
{
  plugins.aerial = {
    enable = true;
    settings = {
      backends = [
        "lsp"
        "treesitter"
        "markdown"
        "man"
      ];
      layout = {
        default_direction = "right";
        placement = "edge";
        resize_to_content = true;
        win_opts = {
          winhl = "Normal:NormalFloat";
        };
      };
      attach_mode = "global";
      close_automatic_events = [
        "unsupported"
      ];
      show_guides = true;
      guides = {
        mid_item = "├ ";
        last_item = "└ ";
        nested_top = "│ ";
        whitespace = "  ";
      };
      filter_kind = false;
      highlight_mode = "split_width";
      highlight_closest = true;
      highlight_on_hover = false;
      highlight_on_jump = 300;
      autojump = false;
      # Let aerial auto-detect mini.icons for icons
      # nerd_font = "auto" is the default, which will use mini.icons if available
      nerd_font = "auto";
      keymaps = {
        "?" = "actions.show_help";
        "g?" = "actions.show_help";
        "<CR>" = "actions.jump";
        "<2-LeftMouse>" = "actions.jump";
        "<C-v>" = "actions.jump_vsplit";
        "<C-s>" = "actions.jump_split";
        "p" = "actions.scroll";
        "<C-j>" = "actions.down_and_scroll";
        "<C-k>" = "actions.up_and_scroll";
        "{" = "actions.prev";
        "}" = "actions.next";
        "[[" = "actions.prev_up";
        "]]" = "actions.next_up";
        q = "actions.close";
        "<Esc>" = "actions.close";
        r = "actions.tree_toggle";
        "R" = "actions.tree_toggle_recursive";
        "W" = "actions.tree_collapse";
        "E" = "actions.tree_expand";
      };
      lazy_load = true;
      disable_max_lines = 10000;
      disable_max_size = 2000000;
      open_automatic = false;
    };
  };

  # Keymaps for aerial
  keymaps = [
    {
      mode = "n";
      key = "<leader>cs";
      action = "<cmd>AerialToggle<CR>";
      options.desc = "Symbols (aerial)";
    }
    {
      mode = "n";
      key = "{";
      action = "<cmd>AerialPrev<CR>";
      options.desc = "Previous Symbol";
    }
    {
      mode = "n";
      key = "}";
      action = "<cmd>AerialNext<CR>";
      options.desc = "Next Symbol";
    }
    {
      mode = "n";
      key = "[[";
      action = "<cmd>AerialPrevUp<CR>";
      options.desc = "Previous Parent Symbol";
    }
    {
      mode = "n";
      key = "]]";
      action = "<cmd>AerialNextUp<CR>";
      options.desc = "Next Parent Symbol";
    }
  ];

  # Add aerial highlight groups to transparent plugin
  plugins.transparent = lib.mkIf config.sieg-nixvim.theme.transparent {
    settings.extra_groups = [
      "AerialNormal"
      "AerialGuide"
    ];
  };
}
